local present, go = pcall(require, "go")
if not present then
  return
end

go.setup({
  build_tags = "wireinject",
})
