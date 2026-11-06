hl.on("hyprland.start", function()
    -- Start the gamma relay.
    hl.exec_cmd("wl-gammarelay-rs")

    -- Wait for its D-Bus service, then set 5000 K.
    hl.exec_cmd(
        "sh -c 'until busctl --user status " ..
        "rs.wl-gammarelay >/dev/null 2>&1; " ..
        "do sleep 0.5; done; " ..
        "busctl --user set-property rs.wl-gammarelay / " ..
        "rs.wl.gammarelay Temperature q 5000'"
    )

    -- Other startup applications.
    hl.exec_cmd("dunst")
    hl.exec_cmd("kitty")

end)

