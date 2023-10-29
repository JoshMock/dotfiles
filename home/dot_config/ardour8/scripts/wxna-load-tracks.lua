-- luacheck: globals ardour Editor C Editing ARDOUR Session
ardour {
    ["type"] = "EditorAction",
    name = "Import WXNA songs",
}

local function system(cmd)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()
  return s
end

local function get_songs()
  local session_dir = '/home/joshmock/wxna-session/'
  local files_raw = system('find ' .. session_dir .. ' -type f | sort -r')
  local files = {}
  for file in string.gmatch(files_raw, '[^\n]+') do
    if string.find(file, ".flac") or string.find(file, '.mp3') then
      files[#files + 1] = file
    end
  end
  return files
end

function factory(unused_params) -- luacheck: ignore
  return function()
    Editor:do_import(
      C.StringVector():add(get_songs()),
      Editing.ImportDistinctFiles,
      Editing.ImportToTrack,
      ARDOUR.SrcQuality.SrcBest,
      ARDOUR.MidiTrackNameSource.SMFTrackNumber,
      ARDOUR.MidiTempoMapDisposition.SMFTempoIgnore,
      Temporal.timepos_t(0),
      ARDOUR.PluginInfo(),
      Session:route_by_name("music"):to_track(),
      false
    )
  end
end
