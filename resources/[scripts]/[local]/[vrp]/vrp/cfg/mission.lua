local cfg = {}

-- mission display css
cfg.display_css =
  [[
  .div_mission{
    position: absolute;
    top: 190px;
    right: 5px;
    color: white;
    background-color: rgba(0,0,0,0.75);
    border:1px solid rgba(255,255,255,0.2);
    box-shadow: 0 0 5px rgba(255, 255, 255, 0.5);
    padding: 10px;
    max-width: 300px;
    font-family: 'Roboto', sans-serif;
    border-radius:8px;
  }

  .div_mission .name{
    color: rgb(255,226,0);
    font-weight: bold;
  }

  .div_mission .step{
    color: rgb(0,255,0);
    font-weight: bold;
  }
]]

return cfg
