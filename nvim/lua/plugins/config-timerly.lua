return {
  {
    "nvzone/timerly",
    dependencies = {
      "nvzone/volt",
    },
    cmd = "TimerlyToggle",
    opts = {
      minutes = { 25, 5 },
      position = "top-right",
    },
  },

  -- toggle mode: m
  -- toggle status: <leader>
  -- increment: <up>
  -- decrement: <down>
  -- reset: <backspace>
}
