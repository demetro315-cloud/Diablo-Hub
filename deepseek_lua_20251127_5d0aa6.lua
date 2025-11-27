return function()
    print("🔮 Diablo Hub Loader Started...")
    
    -- Load the main GUI
    loadstring(game:HttpGet("https://raw.githubusercontent.com/demetro315-cloud/Diablo-Hub/main/gui.lua"))()
    
    print("✅ Diablo Hub Loaded Successfully!")
    print("📝 Press Right Control to open/close GUI")
end