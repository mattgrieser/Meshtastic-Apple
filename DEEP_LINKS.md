# Meshtastic Deep Link Documentation
This document provides a comprehensive guide to the deep link structure available in the Meshtastic iOS, iPadOS, and macOS applications.

### OS

iOS, iPadOS, macOS

### Description

New deep link structures for use with shortcuts, intents and web pages wishing to interact with the meshtastic app.

## Tabs

### Messages

Tab Root - meshtastic:///messages
*In Progress*

Specific Message meshtastic:///messages?channelId={channelIndex}&messageId={messageId}
*In Progress*

### Bluetooth

Tab Root - meshtastic:///bluetooth

### Nodes

Tab Root - meshtastic:///nodes
Selected Node - meshtastic:///nodes?nodenum={nodenum}
*In Progress*

Details Array

deviceMetrics

### Mesh Map

Tab Root - meshtastic:///map
*In Progress*

Node - meshtastic:///map?selectedNode={id}
Waypoint - meshtastic:///map?waypoint={id}

## Settings

Each settings menu item has an associated deep link, there are no parameters for any settings urls.

About Meshtastic - meshtastic:///settings/about
App Settings - meshtastic:///settings/appSettings
Routes - meshtastic:///settings/routes
Route Recorder - meshtastic:///settings/routeRecorder

### Radio Config

LoRa Config - meshtastic:///settings/lora
Channels - meshtastic:///settings/channels
Security Config - meshtastic:///settings/security
Share QR Code - meshtastic:///settings/shareQRCode

### Device Config

User Config - meshtastic:///settings/user
Bluetooth Config - meshtastic:///settings/bluetooth
Device Config - meshtastic:///settings/device
Display Config - meshtastic:///settings/display
Network Config - meshtastic:///settings/network
Position Config - meshtastic:///settings/position
Power Config - meshtastic:///settings/power

### Module Config

Ambient Lighting Module Config - meshtastic:///settings/ambientLighting
Canned Messages Module Config - meshtastic:///settings/cannedMessages
Detection Sensor Module Config - meshtastic:///settings/detectionSensor
External Notification Module Config - meshtastic:///settings/externalNotification
MQTT Module Config - meshtastic:///settings/mqtt
Range Test Module Config - meshtastic:///settings/rangeTest
Ringtone Module Config - meshtastic:///settings/ringtone
Serial Module Config - meshtastic:///settings/serial
Store & Forward Module Config - meshtastic:///settings/storeAndForward
Telemetry Module Config - meshtastic:///settings/telemetry

### Logging

Logs - meshtastic:///settings/debugLogs

### Developers

Mesh Log - meshtastic:///settings/meshLog
App Files - meshtastic:///settings/appFiles

### Firmware

Firmware Updates - meshtastic:///settings/firmwareUpdates