//
//  AppLog.swift
//  Meshtastic
//
//  Created by Garth Vander Houwen on 6/4/24.
//

import SwiftUI
import OSLog

@available(iOS 17.4, *)
struct AppLog: View {

	@State private var logs: [OSLogEntryLog] = []
	@State private var sortOrder = [KeyPathComparator(\OSLogEntryLog.date)]
	@State private var selection: OSLogEntry.ID?
	@State private var selectedLog: OSLogEntryLog?
	@State private var presentingErrorDetails: Bool = false
	@State var isExporting = false
	@State var exportString = ""
	private var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
	private let dateFormatStyle = Date.FormatStyle()
		.hour(.twoDigits(amPM: .omitted))
		.minute()
		.second()
		.secondFraction(.fractional(3))

	var body: some View {

		Table(logs, selection: $selection, sortOrder: $sortOrder) {
			if idiom != .phone {
				TableColumn("Time", value: \.date) { value in
					Text(value.date.formatted(dateFormatStyle))
				}
				.width(min: 100, max: 125)
				TableColumn("Category", value: \.category)
					.width(min: 100, max: 125)
				TableColumn("Level") { value in
					Text(value.level.description)
				}
				.width(min: 50, max: 100)
			}
			TableColumn("Message", value: \.composedMessage)
				.width(ideal: 200, max: .infinity)

		}
		.onChange(of: sortOrder) { _, sortOrder in
			withAnimation {
				logs.sort(using: sortOrder)
			}
		}
		.onChange(of: selection) { newSelection in
			presentingErrorDetails = true
			let log = logs.first {
			   $0.id == newSelection
			 }
			selectedLog = log
		}
		.sheet(item: $selectedLog) { log in
			LogDetail(log: log)
				.padding()
		}
		.task {
			logs = await fetchLogs()
		}
		.fileExporter(
			isPresented: $isExporting,
			document: CsvDocument(emptyCsv: exportString),
			contentType: .commaSeparatedText,
			defaultFilename: String("Meshtastic Application Logs"),
			onCompletion: { result in
				switch result {
				case .success:
					self.isExporting = false
					Logger.services.info("Application log download succeeded.")
				case .failure(let error):
					Logger.services.error("Application log download failed: \(error.localizedDescription)")
				}
			}
		)
		.navigationBarTitle("Debug Logs", displayMode: .inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					exportString = logToCsvFile(log: logs)
					isExporting = true
				}) {
					Image(systemName: "square.and.arrow.down")
				}
			}
		}
	}
}

@available(iOS 17.4, *)
extension AppLog {
	static private let template = NSPredicate(format: "(subsystem BEGINSWITH $PREFIX) || ((subsystem IN $SYSTEM) && ((messageType == error) || (messageType == fault)))")

	@MainActor
	private func fetchLogs() async -> [OSLogEntryLog] {
		let calendar = Calendar.current
		guard let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date.now) else {
			return []
		}
		do {
			let predicate = AppLog.template.withSubstitutionVariables(
				[
					"PREFIX": "gvh.MeshtasticClient",
					"SYSTEM": ["com.apple.coredata"]
				])
			let logs = try await Logger.fetch(since: dayAgo, predicateFormat: predicate.predicateFormat)
			return logs
		} catch {
			return []
		}
	}
}

extension OSLogEntry: Identifiable { }
