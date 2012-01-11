tell application "Safari"
  set rURL to URL of current tab of front window
  set URL of current tab of front window to rURL
end tell
