#!/bin/sh
xcodebuild -workspace 'Autumn.xcworkspace/' -scheme 'UI Tests (STG)' -destination 'platform=iOS Simulator,id=38EBA092-13C4-4512-AC9B-CF4B1F9F4C10' test