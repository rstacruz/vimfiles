if has("gui_macvim")
  aunmenu ToolBar.Open
  aunmenu ToolBar.Save
  aunmenu ToolBar.SaveAll
  aunmenu ToolBar.Print
  aunmenu ToolBar.Undo
  aunmenu ToolBar.Redo
  aunmenu ToolBar.Cut
  aunmenu ToolBar.Copy
  aunmenu ToolBar.Paste
  aunmenu ToolBar.LoadSesn
  aunmenu ToolBar.SaveSesn
  aunmenu ToolBar.RunScript
  aunmenu ToolBar.Make
  aunmenu ToolBar.Help
  "aunmenu ToolBar.Replace
  aunmenu ToolBar.FindNext
  aunmenu ToolBar.FindPrev
  aunmenu ToolBar.RunCtags
  aunmenu ToolBar.TagJump
  aunmenu ToolBar.FindHelp
  aunmenu ToolBar.Lusty

  amenu ToolBar.Lusty :LustyFilesystemExplorer<CR>
endif
