local function augroup(name)
  return vim.api.nvim_create_augroup("joshmock_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("disable_session_persistence"),
  pattern = { "gitcommit" },
  callback = function()
    require("persistence").stop()
  end,
})
