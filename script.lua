

function descriptor()
    return { title="Freebox TV (static)" }
end

function main()
    -- fetch urls for basic channels logos (suppressed)
    -- fetch urls for optional channels logos (suppressed)

    -- fetch the playlist
    fd, msg = vlc.memory_stream(freebox_m3u_text)
    if not fd then
        vlc.msg.warn(msg)
        return nil
    end
    local line=  fd:readline()
    if line ~= "#CUSTOM" then
        return nil
    end
    line = fd:readline()
    local duration, artist, name, arturl
    local options={"deinterlace=1"}
    while line ~= nil do
        if( string.find( line, "#EXTINF" ) ) then
            _, _, duration, artist, name = string.find( line, ":(%w+),(%w+)%s*-%s*(.+)" )
            --arturl = logos[artist]
        elseif( string.find( line, "#EXTVLCOPT" ) ) then
            _, _, option = string.find( line, ":(.+)" )
            table.insert( options, option )
        else
            vlc.sd.add_item({ path = line,
                              duration = duration,
                              artist = artist,
                              title = name,
                              --arturl = arturl,
                              uiddata = line,
                              meta = {["Listing Type"]="tv"},
                              options = options })
            duration = nil
            artist = nil
            name = nil
            --arturl = nil
            options={"deinterlace=1"}
        end
        line = fd:readline()
    end
end

freebox_m3u_text = [[#CUSTOM
#EXTINF:0,2 - France 2 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=201&flavour=hd
#EXTINF:0,2 - France 2 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=201&flavour=sd
#EXTINF:0,2 - France 2 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=201&flavour=ld
#EXTINF:0,2 - France 2 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=201
#EXTINF:0,3 - France 3 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202&flavour=sd
#EXTINF:0,3 - France 3 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202&flavour=ld
#EXTINF:0,3 - France 3 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202&flavour=hd
#EXTINF:0,3 - France 3 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202
#EXTINF:0,5 - France 5 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=203&flavour=sd
#EXTINF:0,5 - France 5 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=203
#EXTINF:0,5 - France 5 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=203&flavour=hd
#EXTINF:0,7 - Arte (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=204&flavour=sd
#EXTINF:0,7 - Arte (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=204&flavour=ld
#EXTINF:0,7 - Arte (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=204&flavour=hd
#EXTINF:0,7 - Arte (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=204
#EXTINF:0,8 - C8 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=372&flavour=sd
#EXTINF:0,10 - TMC (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=497&flavour=sd
#EXTINF:0,10 - TMC (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=497&flavour=ld
#EXTINF:0,10 - TMC (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=497&flavour=hd
#EXTINF:0,10 - TMC (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=497
#EXTINF:0,11 - TFX (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=374&flavour=ld
#EXTINF:0,11 - TFX (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=374&flavour=hd
#EXTINF:0,11 - TFX (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=374&flavour=sd
#EXTINF:0,11 - TFX (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=374
#EXTINF:0,12 - NRJ 12 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=375&flavour=ld
#EXTINF:0,12 - NRJ 12 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=375&flavour=hd
#EXTINF:0,12 - NRJ 12 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=375&flavour=sd
#EXTINF:0,12 - NRJ 12 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=375
#EXTINF:0,13 - La Chaîne Parlementaire (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=226&flavour=ld
#EXTINF:0,13 - La Chaîne Parlementaire (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=226&flavour=hd
#EXTINF:0,13 - La Chaîne Parlementaire (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=226&flavour=sd
#EXTINF:0,13 - La Chaîne Parlementaire (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=226
#EXTINF:0,14 - France 4 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=376&flavour=ld
#EXTINF:0,14 - France 4 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=376&flavour=hd
#EXTINF:0,14 - France 4 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=376&flavour=sd
#EXTINF:0,14 - France 4 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=376
#EXTINF:0,15 - BFM TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=400&flavour=ld
#EXTINF:0,15 - BFM TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=400&flavour=hd
#EXTINF:0,15 - BFM TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=400&flavour=sd
#EXTINF:0,15 - BFM TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=400
#EXTINF:0,16 - CNews (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=679&flavour=sd
#EXTINF:0,17 - CStar (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=678
#EXTINF:0,17 - CStar (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=678&flavour=hd
#EXTINF:0,17 - CStar (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=678&flavour=sd
#EXTINF:0,18 - Gulli (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=677
#EXTINF:0,18 - Gulli (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=677&flavour=hd
#EXTINF:0,19 - France Ô (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=238
#EXTINF:0,19 - France Ô (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=238&flavour=hd
#EXTINF:0,19 - France Ô (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=238&flavour=sd
#EXTINF:0,21 - L'Equipe (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=994&flavour=ld
#EXTINF:0,21 - L'Equipe (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=994
#EXTINF:0,21 - L'Equipe (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=994&flavour=hd
#EXTINF:0,23 - RMC Story (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=996&flavour=ld
#EXTINF:0,23 - RMC Story (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=996
#EXTINF:0,23 - RMC Story (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=996&flavour=hd
#EXTINF:0,24 - RMC Découverte (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=997
#EXTINF:0,24 - RMC Découverte (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=997&flavour=hd
#EXTINF:0,24 - RMC Découverte (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=997&flavour=ld
#EXTINF:0,25 - Chérie 25 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=998
#EXTINF:0,25 - Chérie 25 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=998&flavour=hd
#EXTINF:0,25 - Chérie 25 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=998&flavour=ld
#EXTINF:0,27 - franceinfo (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1173&flavour=hd
#EXTINF:0,27 - franceinfo (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1173&flavour=ld
#EXTINF:0,27 - franceinfo (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1173
#EXTINF:0,28 - Paris Première (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=213&flavour=ld
#EXTINF:0,29 - RTL9 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=210&flavour=hd
#EXTINF:0,29 - RTL9 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=210&flavour=ld
#EXTINF:0,29 - RTL9 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=210
#EXTINF:0,50 - Game One (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=220&flavour=sd
#EXTINF:0,50 - Game One (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=220
#EXTINF:0,50 - Game One (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=220&flavour=hd
#EXTINF:0,51 - AB 1 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=211&flavour=ld
#EXTINF:0,51 - AB 1 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=211&flavour=hd
#EXTINF:0,51 - AB 1 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=211
#EXTINF:0,52 - Paramount Channel (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1050&flavour=hd
#EXTINF:0,52 - Paramount Channel (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1050&flavour=ld
#EXTINF:0,52 - Paramount Channel (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1050
#EXTINF:0,53 - TEVA (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=404&flavour=ld
#EXTINF:0,64 - M6 Music (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=430&flavour=ld
#EXTINF:0,70 - TV5 Monde (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=206
#EXTINF:0,70 - TV5 Monde (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=206&flavour=hd
#EXTINF:0,70 - TV5 Monde (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=206&flavour=sd
#EXTINF:0,87 - MCM (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=621&flavour=sd
#EXTINF:0,89 - Game One +1 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=979&flavour=ld
#EXTINF:0,90 - Mangas (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=253&flavour=hd
#EXTINF:0,90 - Mangas (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=253&flavour=ld
#EXTINF:0,90 - Mangas (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=253
#EXTINF:0,91 - ES1 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1309
#EXTINF:0,91 - ES1 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1309&flavour=hd
#EXTINF:0,91 - ES1 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1309&flavour=ld
#EXTINF:0,94 - GONG (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1045&flavour=ld
#EXTINF:0,94 - GONG (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1045
#EXTINF:0,94 - GONG (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1045&flavour=hd
#EXTINF:0,95 - GONG MAX (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=813&flavour=sd
#EXTINF:0,95 - GONG MAX (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=813
#EXTINF:0,95 - GONG MAX (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=813&flavour=hd
#EXTINF:0,96 - Ginx (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=618&flavour=sd
#EXTINF:0,97 - Comedy Central (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1318&flavour=ld
#EXTINF:0,97 - Comedy Central (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1318
#EXTINF:0,97 - Comedy Central (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1318&flavour=hd
#EXTINF:0,99 - BET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1135&flavour=ld
#EXTINF:0,99 - BET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1135
#EXTINF:0,99 - BET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1135&flavour=hd
#EXTINF:0,100 - Festival 4K (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1134&flavour=hd
#EXTINF:0,119 - Eurochannel (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=959&flavour=hd
#EXTINF:0,120 - Drive In Movie Channel (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1295&flavour=ld
#EXTINF:0,121 - Action (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=242&flavour=ld
#EXTINF:0,121 - Action (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=242&flavour=hd
#EXTINF:0,121 - Action (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=242
#EXTINF:0,122 - Paramount Décalé (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1167&flavour=hd
#EXTINF:0,122 - Paramount Décalé (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1167&flavour=ld
#EXTINF:0,122 - Paramount Décalé (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1167
#EXTINF:0,154 - Toonami (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1163&flavour=ld
#EXTINF:0,154 - Toonami (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1163
#EXTINF:0,154 - Toonami (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1163&flavour=hd
#EXTINF:0,175 - Premiere Futebol Clube (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=755&flavour=sd
#EXTINF:0,176 - Equidia (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=212&flavour=hd
#EXTINF:0,176 - Equidia (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=212&flavour=sd
#EXTINF:0,176 - Equidia (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=212
#EXTINF:0,178 - Trace Sport Stars (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=965
#EXTINF:0,178 - Trace Sport Stars (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=965&flavour=hd
#EXTINF:0,178 - Trace Sport Stars (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=965&flavour=ld
#EXTINF:0,179 - Fight Box HD (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=969&flavour=hd
#EXTINF:0,180 - Automoto (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=222&flavour=ld
#EXTINF:0,180 - Automoto (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=222&flavour=hd
#EXTINF:0,180 - Automoto (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=222
#EXTINF:0,182 - Motorvision (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1127&flavour=hd
#EXTINF:0,183 - Nautical Channel (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=255
#EXTINF:0,183 - Nautical Channel (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=255&flavour=hd
#EXTINF:0,183 - Nautical Channel (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=255&flavour=sd
#EXTINF:0,185 - Golf Channel (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=892
#EXTINF:0,185 - Golf Channel (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=892&flavour=hd
#EXTINF:0,185 - Golf Channel (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=892&flavour=ld
#EXTINF:0,202 - Crime District (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1314
#EXTINF:0,202 - Crime District (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1314&flavour=hd
#EXTINF:0,202 - Crime District (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1314&flavour=ld
#EXTINF:0,205 - Histoire (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=235&flavour=hd
#EXTINF:0,205 - Histoire (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=235&flavour=ld
#EXTINF:0,205 - Histoire (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=235
#EXTINF:0,206 - Toute l'histoire (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=250&flavour=hd
#EXTINF:0,206 - Toute l'histoire (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=250&flavour=ld
#EXTINF:0,206 - Toute l'histoire (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=250
#EXTINF:0,207 - Science & Vie TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=251&flavour=ld
#EXTINF:0,207 - Science & Vie TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=251
#EXTINF:0,207 - Science & Vie TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=251&flavour=hd
#EXTINF:0,208 - Animaux (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=248&flavour=hd
#EXTINF:0,208 - Animaux (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=248&flavour=ld
#EXTINF:0,208 - Animaux (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=248
#EXTINF:0,209 - Trek (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=252&flavour=hd
#EXTINF:0,209 - Trek (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=252&flavour=ld
#EXTINF:0,209 - Trek (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=252
#EXTINF:0,210 - Aerostar (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1162&flavour=ld
#EXTINF:0,210 - Aerostar (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1162
#EXTINF:0,210 - Aerostar (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1162&flavour=hd
#EXTINF:0,211 - Souvenirs from Earth (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=710&flavour=hd
#EXTINF:0,211 - Souvenirs from Earth (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=710&flavour=sd
#EXTINF:0,211 - Souvenirs from Earth (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=710
#EXTINF:0,212 - Ikono (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1072&flavour=hd
#EXTINF:0,214 - Purescreens Nature HD (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=825&flavour=hd
#EXTINF:0,215 - Travel Channel (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=772&flavour=sd
#EXTINF:0,216 - Chasse et pêche (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=249
#EXTINF:0,216 - Chasse et pêche (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=249&flavour=hd
#EXTINF:0,216 - Chasse et pêche (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=249&flavour=ld
#EXTINF:0,218 - Telesud (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=356&flavour=sd
#EXTINF:0,219 - Tahiti Nui (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1297
#EXTINF:0,219 - Tahiti Nui (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1297&flavour=hd
#EXTINF:0,219 - Tahiti Nui (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1297&flavour=ld
#EXTINF:0,232 - M6 Boutique & Co (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=359
#EXTINF:0,232 - M6 Boutique & Co (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=359&flavour=ld
#EXTINF:0,232 - M6 Boutique & Co (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=359&flavour=sd
#EXTINF:0,233 - Best of Shopping (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=358
#EXTINF:0,233 - Best of Shopping (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=358&flavour=ld
#EXTINF:0,233 - Best of Shopping (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=358&flavour=sd
#EXTINF:0,234 - QVC (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1121
#EXTINF:0,234 - QVC (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1121&flavour=hd
#EXTINF:0,234 - QVC (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1121&flavour=ld
#EXTINF:0,235 - Astro Center TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=415&flavour=sd
#EXTINF:0,236 - Demain.tv (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=227&flavour=sd
#EXTINF:0,237 - Luxe.TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=460&flavour=hd
#EXTINF:0,237 - Luxe.TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=460&flavour=sd
#EXTINF:0,237 - Luxe.TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=460
#EXTINF:0,238 - Men's Up TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=878&flavour=ld
#EXTINF:0,239 - Ouatch TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1076
#EXTINF:0,239 - Ouatch TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1076&flavour=hd
#EXTINF:0,239 - Ouatch TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1076&flavour=ld
#EXTINF:0,240 - World Fashion (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=724&flavour=sd
#EXTINF:0,241 - Fashion TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=221&flavour=sd
#EXTINF:0,242 - FTV HD (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=454&flavour=hd
#EXTINF:0,244 - Lucky Jack (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=891
#EXTINF:0,244 - Lucky Jack (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=891&flavour=hd
#EXTINF:0,244 - Lucky Jack (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=891&flavour=ld
#EXTINF:0,245 - KTO (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=223&flavour=sd
#EXTINF:0,246 - ECTV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1082&flavour=ld
#EXTINF:0,261 - RFM TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=623&flavour=sd
#EXTINF:0,262 - Melody (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=237&flavour=sd
#EXTINF:0,263 - Mezzo (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=265&flavour=sd
#EXTINF:0,264 - Mezzo Live HD (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=858&flavour=hd
#EXTINF:0,266 - Stingray Brava (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=820&flavour=hd
#EXTINF:0,270 - Virgin Radio TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1071&flavour=ld
#EXTINF:0,271 - MCM TOP (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=622&flavour=sd
#EXTINF:0,271 - MCM TOP (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=622
#EXTINF:0,271 - MCM TOP (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=622&flavour=hd
#EXTINF:0,274 - Clubbing TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=767&flavour=hd
#EXTINF:0,274 - Clubbing TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=767&flavour=ld
#EXTINF:0,274 - Clubbing TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=767
#EXTINF:0,278 - C Music (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=683&flavour=sd
#EXTINF:0,279 - VH1 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=233&flavour=sd
#EXTINF:0,280 - VH1 Classic (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=232&flavour=sd
#EXTINF:0,281 - OKLM (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1166&flavour=hd
#EXTINF:0,281 - OKLM (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1166&flavour=ld
#EXTINF:0,281 - OKLM (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1166
#EXTINF:0,282 - Generations TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1305&flavour=hd
#EXTINF:0,282 - Generations TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1305&flavour=ld
#EXTINF:0,282 - Generations TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1305
#EXTINF:0,283 - People 24 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=981&flavour=ld
#EXTINF:0,287 - Trace Urban (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=228&flavour=sd
#EXTINF:0,287 - Trace Urban (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=228
#EXTINF:0,287 - Trace Urban (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=228&flavour=hd
#EXTINF:0,288 - Trace Tropical (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=769&flavour=hd
#EXTINF:0,288 - Trace Tropical (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=769&flavour=sd
#EXTINF:0,288 - Trace Tropical (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=769
#EXTINF:0,289 - Trace Toca (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1137&flavour=ld
#EXTINF:0,290 - Trace Gospel (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1136&flavour=hd
#EXTINF:0,290 - Trace Gospel (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1136&flavour=ld
#EXTINF:0,290 - Trace Gospel (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1136
#EXTINF:0,294 - Melody d'Afrique (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1306&flavour=ld
#EXTINF:0,301 - France 3 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202&flavour=sd
#EXTINF:0,301 - France 3 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202&flavour=ld
#EXTINF:0,301 - France 3 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202&flavour=hd
#EXTINF:0,301 - France 3 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=202
#EXTINF:0,302 - France 3 Alpes (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=283&flavour=sd
#EXTINF:0,302 - France 3 Alpes (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=283
#EXTINF:0,302 - France 3 Alpes (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=283&flavour=hd
#EXTINF:0,303 - France 3 Alsace (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=280&flavour=sd
#EXTINF:0,303 - France 3 Alsace (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=280
#EXTINF:0,303 - France 3 Alsace (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=280&flavour=hd
#EXTINF:0,304 - France 3 Aquitaine (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=284&flavour=sd
#EXTINF:0,304 - France 3 Aquitaine (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=284
#EXTINF:0,304 - France 3 Aquitaine (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=284&flavour=hd
#EXTINF:0,305 - France 3 Auvergne (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=285&flavour=sd
#EXTINF:0,305 - France 3 Auvergne (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=285
#EXTINF:0,305 - France 3 Auvergne (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=285&flavour=hd
#EXTINF:0,306 - France 3 Basse-Normandie (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=298&flavour=sd
#EXTINF:0,306 - France 3 Basse-Normandie (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=298
#EXTINF:0,306 - France 3 Basse-Normandie (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=298&flavour=hd
#EXTINF:0,307 - France 3 Bourgogne (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=279&flavour=sd
#EXTINF:0,307 - France 3 Bourgogne (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=279
#EXTINF:0,307 - France 3 Bourgogne (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=279&flavour=hd
#EXTINF:0,308 - France 3 Bretagne (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=286&flavour=sd
#EXTINF:0,308 - France 3 Bretagne (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=286
#EXTINF:0,308 - France 3 Bretagne (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=286&flavour=hd
#EXTINF:0,309 - France 3 Centre (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=287&flavour=sd
#EXTINF:0,309 - France 3 Centre (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=287
#EXTINF:0,309 - France 3 Centre (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=287&flavour=hd
#EXTINF:0,310 - France 3 Champagne-Ardenne (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=288&flavour=sd
#EXTINF:0,310 - France 3 Champagne-Ardenne (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=288
#EXTINF:0,310 - France 3 Champagne-Ardenne (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=288&flavour=hd
#EXTINF:0,311 - France 3 Corse Via Stella (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=289&flavour=sd
#EXTINF:0,311 - France 3 Corse Via Stella (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=289
#EXTINF:0,311 - France 3 Corse Via Stella (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=289&flavour=hd
#EXTINF:0,312 - France 3 Côte-d'Azur (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=290&flavour=sd
#EXTINF:0,312 - France 3 Côte-d'Azur (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=290
#EXTINF:0,312 - France 3 Côte-d'Azur (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=290&flavour=hd
#EXTINF:0,313 - France 3 Franche-Comté (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=291&flavour=sd
#EXTINF:0,313 - France 3 Franche-Comté (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=291
#EXTINF:0,313 - France 3 Franche-Comté (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=291&flavour=hd
#EXTINF:0,314 - France 3 Haute-Normandie (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=297&flavour=sd
#EXTINF:0,314 - France 3 Haute-Normandie (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=297
#EXTINF:0,314 - France 3 Haute-Normandie (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=297&flavour=hd
#EXTINF:0,315 - France 3 Languedoc-Roussillon (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=292&flavour=sd
#EXTINF:0,315 - France 3 Languedoc-Roussillon (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=292
#EXTINF:0,315 - France 3 Languedoc-Roussillon (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=292&flavour=hd
#EXTINF:0,316 - France 3 Limousin (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=293&flavour=sd
#EXTINF:0,316 - France 3 Limousin (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=293
#EXTINF:0,316 - France 3 Limousin (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=293&flavour=hd
#EXTINF:0,317 - France 3 Lorraine (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=294&flavour=sd
#EXTINF:0,317 - France 3 Lorraine (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=294
#EXTINF:0,317 - France 3 Lorraine (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=294&flavour=hd
#EXTINF:0,318 - France 3 Midi Pyrénées (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=295&flavour=sd
#EXTINF:0,318 - France 3 Midi Pyrénées (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=295
#EXTINF:0,318 - France 3 Midi Pyrénées (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=295&flavour=hd
#EXTINF:0,319 - France 3 Nord Pas-de-Calais (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=296&flavour=sd
#EXTINF:0,319 - France 3 Nord Pas-de-Calais (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=296
#EXTINF:0,319 - France 3 Nord Pas-de-Calais (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=296&flavour=hd
#EXTINF:0,320 - France 3 Paris Ile-de-France (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=257&flavour=sd
#EXTINF:0,320 - France 3 Paris Ile-de-France (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=257
#EXTINF:0,320 - France 3 Paris Ile-de-France (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=257&flavour=hd
#EXTINF:0,321 - France 3 Pays de Loire (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=299&flavour=sd
#EXTINF:0,321 - France 3 Pays de Loire (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=299
#EXTINF:0,321 - France 3 Pays de Loire (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=299&flavour=hd
#EXTINF:0,322 - France 3 Picardie (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=300&flavour=sd
#EXTINF:0,322 - France 3 Picardie (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=300
#EXTINF:0,322 - France 3 Picardie (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=300&flavour=hd
#EXTINF:0,323 - France 3 Poitou-Charentes (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=301&flavour=sd
#EXTINF:0,323 - France 3 Poitou-Charentes (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=301
#EXTINF:0,323 - France 3 Poitou-Charentes (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=301&flavour=hd
#EXTINF:0,324 - France 3 Provence-Alpes (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=302&flavour=sd
#EXTINF:0,324 - France 3 Provence-Alpes (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=302
#EXTINF:0,324 - France 3 Provence-Alpes (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=302&flavour=hd
#EXTINF:0,325 - France 3 Rhône-Alpes (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=303&flavour=sd
#EXTINF:0,325 - France 3 Rhône-Alpes (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=303
#EXTINF:0,325 - France 3 Rhône-Alpes (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=303&flavour=hd
#EXTINF:0,326 - NoA (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1315&flavour=hd
#EXTINF:0,326 - NoA (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1315&flavour=ld
#EXTINF:0,326 - NoA (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1315
#EXTINF:0,340 - France 24 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=739&flavour=sd
#EXTINF:0,341 - France 24 English (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=740&flavour=sd
#EXTINF:0,342 - France 24 Arab (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=741&flavour=sd
#EXTINF:0,343 - LCP - Assemblée Nationale 24h/24 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=688
#EXTINF:0,343 - LCP - Assemblée Nationale 24h/24 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=688&flavour=hd
#EXTINF:0,343 - LCP - Assemblée Nationale 24h/24 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=688&flavour=sd
#EXTINF:0,344 - Public Sénat (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=692&flavour=hd
#EXTINF:0,344 - Public Sénat (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=692&flavour=sd
#EXTINF:0,344 - Public Sénat (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=692
#EXTINF:0,345 - Euronews (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=205&flavour=sd
#EXTINF:0,346 - Euronews Int (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=949&flavour=sd
#EXTINF:0,347 - BFM Business (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=897&flavour=ld
#EXTINF:0,347 - BFM Business (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=897
#EXTINF:0,347 - BFM Business (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=897&flavour=hd
#EXTINF:0,348 - Arretsurimages.tv (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=738&flavour=sd
#EXTINF:0,350 - Sky News International (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=355&flavour=sd
#EXTINF:0,352 - Fox News (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1073&flavour=ld
#EXTINF:0,353 - Bloomberg TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=207&flavour=sd
#EXTINF:0,354 - CNBC (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=208&flavour=sd
#EXTINF:0,355 - Al Jazeera International (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=494&flavour=sd
#EXTINF:0,357 - i24 News (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1048&flavour=ld
#EXTINF:0,358 - NHK World-Japan (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=812&flavour=sd
#EXTINF:0,358 - NHK World-Japan (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=812
#EXTINF:0,358 - NHK World-Japan (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=812&flavour=hd
#EXTINF:0,359 - Russia Today France (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1304&flavour=ld
#EXTINF:0,359 - Russia Today France (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1304
#EXTINF:0,359 - Russia Today France (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1304&flavour=hd
#EXTINF:0,420 - God TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=386&flavour=sd
#EXTINF:0,421 - Noursat (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1069&flavour=ld
#EXTINF:0,422 - Daystar (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1141&flavour=ld
#EXTINF:0,426 - BBC Entertainment (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=413&flavour=sd
#EXTINF:0,430 - UbizNews (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1110&flavour=ld
#EXTINF:0,431 - Nina TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1296&flavour=ld
#EXTINF:0,432 - TPA (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1115&flavour=ld
#EXTINF:0,433 - TNH (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1129&flavour=ld
#EXTINF:0,436 - HLive (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1126&flavour=ld
#EXTINF:0,444 - A+ (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1232&flavour=sd
#EXTINF:0,444 - A+ (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1232
#EXTINF:0,444 - A+ (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1232&flavour=hd
#EXTINF:0,445 - Antenne A (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1143&flavour=ld
#EXTINF:0,446 - B-One TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1085&flavour=ld
#EXTINF:0,447 - Maïsha TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1086&flavour=ld
#EXTINF:0,448 - Sen TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1087&flavour=ld
#EXTINF:0,449 - TVT (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1088&flavour=ld
#EXTINF:0,450 - RTB (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=774&flavour=sd
#EXTINF:0,451 - ORTB (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=810&flavour=sd
#EXTINF:0,452 - TFM (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=960&flavour=sd
#EXTINF:0,453 - Canal 2 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=781&flavour=sd
#EXTINF:0,454 - CRTV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=782&flavour=sd
#EXTINF:0,455 - STV2 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=783&flavour=sd
#EXTINF:0,456 - Equinoxe TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=833&flavour=sd
#EXTINF:0,457 - Trace Africa (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=963&flavour=sd
#EXTINF:0,458 - Télé Congo (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=784&flavour=sd
#EXTINF:0,460 - Nollywood (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=800&flavour=ld
#EXTINF:0,461 - RTI 1 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=941&flavour=sd
#EXTINF:0,462 - Gabon Télévision (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=916&flavour=ld
#EXTINF:0,463 - RTG (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=917&flavour=ld
#EXTINF:0,465 - ORTM (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=785&flavour=sd
#EXTINF:0,466 - 2STV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=786&flavour=sd
#EXTINF:0,467 - RTS (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=787&flavour=sd
#EXTINF:0,469 - Africable (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=788&flavour=sd
#EXTINF:0,470 - SUD1ere (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1068&flavour=ld
#EXTINF:0,471 - TVM (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1124&flavour=ld
#EXTINF:0,472 - ORTC (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=888&flavour=ld
#EXTINF:0,473 - MBC Sat (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1123&flavour=ld
#EXTINF:0,474 - Telekreol (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1120&flavour=ld
#EXTINF:0,475 - Vox Africa (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=773&flavour=sd
#EXTINF:0,477 - OutreMer 5 TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=468&flavour=sd
#EXTINF:0,478 - MBOA TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=837&flavour=ld
#EXTINF:0,479 - LBC Sat (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1099&flavour=ld
#EXTINF:0,480 - Medi1TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=730&flavour=sd
#EXTINF:0,481 - Canal Algérie (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=274&flavour=sd
#EXTINF:0,482 - Algérie 3 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=943&flavour=ld
#EXTINF:0,483 - Algérie 5 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=944&flavour=ld
#EXTINF:0,484 - Tamazight TV4 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=945&flavour=ld
#EXTINF:0,485 - Al Erth Al Nabawi (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1090&flavour=ld
#EXTINF:0,486 - Beur TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=225&flavour=ld
#EXTINF:0,487 - Berbère TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=256&flavour=sd
#EXTINF:0,488 - Berbère Jeunesse (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=936&flavour=sd
#EXTINF:0,489 - Berbère Music (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=937&flavour=sd
#EXTINF:0,490 - Al Ahly (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1093&flavour=ld
#EXTINF:0,491 - Al Resalah (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=922&flavour=ld
#EXTINF:0,492 - Rotana Aflam (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1094&flavour=ld
#EXTINF:0,493 - Rotana Cinema (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=920&flavour=ld
#EXTINF:0,494 - Rotana Clip (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=923&flavour=ld
#EXTINF:0,495 - Rotana Khalijia (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=921&flavour=ld
#EXTINF:0,496 - Rotana Masriya (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1095&flavour=ld
#EXTINF:0,497 - Rotana Music Channel (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=924&flavour=ld
#EXTINF:0,498 - Rotana Classic (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=925&flavour=ld
#EXTINF:0,499 - Trace Naija (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1175&flavour=ld
#EXTINF:0,500 - Trace Mziki (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1176&flavour=ld
#EXTINF:0,502 - TV Polonia (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=278&flavour=sd
#EXTINF:0,503 - TVN 24 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=794&flavour=sd
#EXTINF:0,504 - ITVN (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=795&flavour=sd
#EXTINF:0,506 - Vietnam VTV4 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=723&flavour=sd
#EXTINF:0,507 - VTC 10 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1225&flavour=ld
#EXTINF:0,508 - VTV1 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1226&flavour=ld
#EXTINF:0,509 - VTV3 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1227&flavour=ld
#EXTINF:0,510 - HTV9 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1228&flavour=ld
#EXTINF:0,514 - Zee TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=420&flavour=sd
#EXTINF:0,515 - Zee Cinema (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=421&flavour=sd
#EXTINF:0,516 - Arirang (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=894&flavour=ld
#EXTINF:0,518 - B4U Music (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=904&flavour=ld
#EXTINF:0,521 - TV Romania (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=318&flavour=sd
#EXTINF:0,522 - Pro TV Int. (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=961&flavour=ld
#EXTINF:0,523 - Antena 3 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1101&flavour=ld
#EXTINF:0,524 - Atres Series (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1102
#EXTINF:0,524 - Atres Series (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1102&flavour=hd
#EXTINF:0,524 - Atres Series (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1102&flavour=ld
#EXTINF:0,525 - Sol Musica (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1103&flavour=ld
#EXTINF:0,526 - TV3 Cataluna (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1104&flavour=ld
#EXTINF:0,527 - Galicia TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1105&flavour=ld
#EXTINF:0,528 - ETB Sat (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=371&flavour=ld
#EXTINF:0,529 - Star TVE HD (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1293
#EXTINF:0,529 - Star TVE HD (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1293&flavour=hd
#EXTINF:0,529 - Star TVE HD (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1293&flavour=ld
#EXTINF:0,531 - Telesur (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=729&flavour=sd
#EXTINF:0,532 - Ritmoson Latino (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=407&flavour=sd
#EXTINF:0,533 - De pelicula (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=408&flavour=sd
#EXTINF:0,534 - TL Novelas (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=409&flavour=sd
#EXTINF:0,535 - Canal de las Estrellas (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=410&flavour=sd
#EXTINF:0,536 - Telehit (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=411&flavour=sd
#EXTINF:0,537 - TVE I (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=306&flavour=sd
#EXTINF:0,538 - Canal 24 Horas (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=307&flavour=sd
#EXTINF:0,542 - Antenna 1 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=771&flavour=sd
#EXTINF:0,543 - Rai Uno (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=309&flavour=sd
#EXTINF:0,544 - Rai Due (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=314&flavour=sd
#EXTINF:0,545 - Rai Tre (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=315&flavour=sd
#EXTINF:0,546 - Mediaset Italia (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=839&flavour=ld
#EXTINF:0,550 - Numidia TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1164&flavour=ld
#EXTINF:0,552 - Tamazight TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1138&flavour=ld
#EXTINF:0,553 - Al Magharibia (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1142&flavour=ld
#EXTINF:0,554 - IMED TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=838&flavour=ld
#EXTINF:0,555 - Ennahar (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1070&flavour=ld
#EXTINF:0,556 - Echorouk TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1160&flavour=ld
#EXTINF:0,557 - Ulusal Kanal (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=914&flavour=ld
#EXTINF:0,558 - Arriyadia (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=908&flavour=ld
#EXTINF:0,559 - Canal Atlas (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1139&flavour=ld
#EXTINF:0,564 - 2M Maroc (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=272&flavour=sd
#EXTINF:0,565 - TVM Europe (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=273&flavour=sd
#EXTINF:0,566 - El Hiwar Ettounsi (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1133&flavour=ld
#EXTINF:0,567 - Télévision Tunisienne (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=277&flavour=sd
#EXTINF:0,568 - Al Masriya (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=275&flavour=sd
#EXTINF:0,569 - Al Jazeera (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=276&flavour=sd
#EXTINF:0,570 - Jeem TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=412&flavour=sd
#EXTINF:0,572 - ART Cinema (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=327&flavour=sd
#EXTINF:0,573 - ART Aflam 1 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=328&flavour=sd
#EXTINF:0,574 - Art Hekayat (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=330&flavour=sd
#EXTINF:0,575 - Iqraa (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=331&flavour=sd
#EXTINF:0,576 - ART Aflam 2 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=332&flavour=sd
#EXTINF:0,577 - Cima (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=333&flavour=sd
#EXTINF:0,578 - Baraem (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=750&flavour=sd
#EXTINF:0,580 - ART Hekayat 2 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=336&flavour=sd
#EXTINF:0,581 - O'TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=685&flavour=sd
#EXTINF:0,582 - Powertürk TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=489
#EXTINF:0,582 - Powertürk TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=489&flavour=hd
#EXTINF:0,582 - Powertürk TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=489&flavour=sd
#EXTINF:0,583 - TRT1 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=490&flavour=sd
#EXTINF:0,584 - Kanal D (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=463&flavour=sd
#EXTINF:0,585 - Star TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=464&flavour=sd
#EXTINF:0,586 - TRT Cocuk (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=798&flavour=sd
#EXTINF:0,587 - SkyTurk (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=913&flavour=ld
#EXTINF:0,588 - ATV Avrupa (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=467&flavour=sd
#EXTINF:0,589 - Kanal 24 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=435&flavour=sd
#EXTINF:0,590 - TRT INT (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=369&flavour=sd
#EXTINF:0,591 - Kanal 7 INT (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=370&flavour=sd
#EXTINF:0,594 - Hilal TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=446&flavour=sd
#EXTINF:0,595 - TV5 Turkey (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=447&flavour=sd
#EXTINF:0,596 - TGRT EU (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=465&flavour=sd
#EXTINF:0,597 - TV8 Int (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=700&flavour=sd
#EXTINF:0,600 - Halk TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1046&flavour=ld
#EXTINF:0,601 - GeoTV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=702&flavour=sd
#EXTINF:0,602 - GeoNews (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=703&flavour=sd
#EXTINF:0,603 - B4U Movies (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=704&flavour=sd
#EXTINF:0,609 - KBS (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=761&flavour=sd
#EXTINF:0,614 - The Israeli Network (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=462&flavour=sd
#EXTINF:0,616 - Arte Allemand (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=270&flavour=sd
#EXTINF:0,617 - DW-TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=312&flavour=sd
#EXTINF:0,618 - RTL (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=985&flavour=ld
#EXTINF:0,619 - RTL2 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=986&flavour=ld
#EXTINF:0,620 - Super RTL (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=987&flavour=ld
#EXTINF:0,621 - RTL Nitro (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=988&flavour=ld
#EXTINF:0,622 - Vox (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=989&flavour=ld
#EXTINF:0,623 - ProSieben (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=990&flavour=ld
#EXTINF:0,624 - Sat1 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=991&flavour=ld
#EXTINF:0,625 - NTV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=992&flavour=ld
#EXTINF:0,626 - N24 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1089&flavour=ld
#EXTINF:0,627 - SIC (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=484&flavour=sd
#EXTINF:0,628 - SIC Noticias (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1038&flavour=ld
#EXTINF:0,629 - TVI International (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1039&flavour=ld
#EXTINF:0,631 - A Bola TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1041&flavour=ld
#EXTINF:0,632 - Porto Canal (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1042&flavour=ld
#EXTINF:0,633 - Baby TV (portugais) (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1043&flavour=ld
#EXTINF:0,635 - Canal Q (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1049&flavour=ld
#EXTINF:0,636 - TVI  Ficcao (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1059&flavour=sd
#EXTINF:0,637 - RTPi (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=388&flavour=sd
#EXTINF:0,638 - TV Globo Internacional (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=722&flavour=sd
#EXTINF:0,639 - Deepam (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=903&flavour=ld
#EXTINF:0,640 - Kuwait TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=717&flavour=sd
#EXTINF:0,643 - Yemen TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=715&flavour=sd
#EXTINF:0,644 - Dubai TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=748&flavour=sd
#EXTINF:0,645 - Abu Dhabi TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=749&flavour=sd
#EXTINF:0,648 - Jordan Satellite Channel (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=718&flavour=sd
#EXTINF:0,649 - Kentron TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1159&flavour=ld
#EXTINF:0,650 - Armenia Public TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=380&flavour=sd
#EXTINF:0,651 - Armenia TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=751&flavour=sd
#EXTINF:0,652 - Shant TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=752&flavour=sd
#EXTINF:0,653 - Rossiya 24 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=792&flavour=sd
#EXTINF:0,654 - Murr TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=843&flavour=ld
#EXTINF:0,655 - NBN (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=844&flavour=ld
#EXTINF:0,656 - Future TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=845&flavour=ld
#EXTINF:0,657 - Nessma (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=957&flavour=ld
#EXTINF:0,658 - Al Jadeed (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=846&flavour=ld
#EXTINF:0,661 - AlMajd Holy Quran (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=807&flavour=sd
#EXTINF:0,662 - Almajd Al Hadeeth Al Nabawy (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=808&flavour=sd
#EXTINF:0,663 - AlMajd Space Channel (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=809&flavour=sd
#EXTINF:0,664 - Iqraa Int (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1035&flavour=hd
#EXTINF:0,665 - Azhari TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=817&flavour=sd
#EXTINF:0,666 - Mazzika (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=876&flavour=sd
#EXTINF:0,667 - Panorama Cinema (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1168&flavour=ld
#EXTINF:0,668 - Panorama Drama (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1169&flavour=ld
#EXTINF:0,669 - Samira TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1132&flavour=ld
#EXTINF:0,670 - MBC Masr (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=884&flavour=ld
#EXTINF:0,671 - MBC Drama (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1091&flavour=ld
#EXTINF:0,672 - MBC 3 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=902&flavour=ld
#EXTINF:0,673 - MBC (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=334&flavour=ld
#EXTINF:0,674 - Al Arabiya (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1092&flavour=ld
#EXTINF:0,675 - Dzair TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1170&flavour=ld
#EXTINF:0,676 - Dzair News (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1171&flavour=ld
#EXTINF:0,677 - Al Rawda (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1229&flavour=ld
#EXTINF:0,678 - Basma (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1230&flavour=ld
#EXTINF:0,679 - Majid (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1231&flavour=ld
#EXTINF:0,681 - JSTV 1 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=814&flavour=sd
#EXTINF:0,682 - JSTV 2 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=815&flavour=sd
#EXTINF:0,685 - Star Vijay (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=968&flavour=sd
#EXTINF:0,686 - Star Life OK (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=821&flavour=sd
#EXTINF:0,688 - Star plus (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=823&flavour=sd
#EXTINF:0,689 - Star gold (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=824&flavour=sd
#EXTINF:0,690 - RTV Pink Plus (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=439&flavour=sd
#EXTINF:0,691 - RTV Pink Extra (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=440&flavour=sd
#EXTINF:0,692 - Pink Film (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=889&flavour=sd
#EXTINF:0,693 - Pink Music (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=890&flavour=sd
#EXTINF:0,695 - Russia Today (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=726&flavour=hd
#EXTINF:0,695 - Russia Today (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=726&flavour=sd
#EXTINF:0,695 - Russia Today (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=726
#EXTINF:0,696 - Russia Today Espanol (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=856&flavour=ld
#EXTINF:0,696 - Russia Today Espanol (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=856
#EXTINF:0,696 - Russia Today Espanol (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=856&flavour=hd
#EXTINF:0,697 - Record Internacional (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=728&flavour=sd
#EXTINF:0,697 - Record Internacional (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=728
#EXTINF:0,697 - Record Internacional (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=728&flavour=hd
#EXTINF:0,698 - Russian Al Yaum (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=899&flavour=ld
#EXTINF:0,699 - Record News (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=909&flavour=ld
#EXTINF:0,700 - Karusel (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=919&flavour=ld
#EXTINF:0,701 - Channel 1 Russia (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=357&flavour=sd
#EXTINF:0,702 - CTC (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1117&flavour=ld
#EXTINF:0,703 - TNT Comedy (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1118&flavour=ld
#EXTINF:0,704 - RTR Planeta (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=317&flavour=sd
#EXTINF:0,705 - TV1000 Kino (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1119&flavour=ld
#EXTINF:0,706 - Dom Kino (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=840&flavour=ld
#EXTINF:0,707 - Muzika Pervoyo (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=841&flavour=ld
#EXTINF:0,708 - Vremya (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=842&flavour=ld
#EXTINF:0,719 - Mandarin TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1131
#EXTINF:0,719 - Mandarin TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1131&flavour=hd
#EXTINF:0,719 - Mandarin TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1131&flavour=ld
#EXTINF:0,720 - CGTN-Documentaire (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=948&flavour=sd
#EXTINF:0,721 - CCTV4 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=469&flavour=sd
#EXTINF:0,722 - CGTN-News (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=479&flavour=sd
#EXTINF:0,723 - CGTN F (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=480&flavour=sd
#EXTINF:0,724 - CCTV Divertissement (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=470&flavour=sd
#EXTINF:0,725 - La chaîne chinoise (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=471&flavour=sd
#EXTINF:0,726 - Beijing TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=472&flavour=sd
#EXTINF:0,727 - Shanghai Dragon TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=473&flavour=sd
#EXTINF:0,728 - La chaîne internationale de Jiangsu (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=474&flavour=sd
#EXTINF:0,729 - Hunan Satellite TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=475&flavour=sd
#EXTINF:0,730 - Xiamen Star TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=476&flavour=sd
#EXTINF:0,731 - Zhejiang Star TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=477&flavour=sd
#EXTINF:0,732 - Guangdong Southern TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=478&flavour=sd
#EXTINF:0,733 - Phoenix Infonews (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=481&flavour=sd
#EXTINF:0,734 - Phoenix Chinese News and Entertainment (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=266&flavour=sd
#EXTINF:0,740 - CCTV-4 International Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1236&flavour=ld
#EXTINF:0,741 - Beijing TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1237&flavour=ld
#EXTINF:0,742 - Dragon TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1238&flavour=ld
#EXTINF:0,743 - Xiamen TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1239&flavour=ld
#EXTINF:0,744 - Hunan TV - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1240
#EXTINF:0,744 - Hunan TV - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1240&flavour=hd
#EXTINF:0,744 - Hunan TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1240&flavour=ld
#EXTINF:0,745 - Phoenix News - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1241&flavour=ld
#EXTINF:0,746 - Phoenix Europe - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1242&flavour=ld
#EXTINF:0,747 - Star TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1243&flavour=ld
#EXTINF:0,748 - CNTV-15 Music - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1244&flavour=ld
#EXTINF:0,749 - CNTV-1 General - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1245&flavour=ld
#EXTINF:0,750 - Neimenggu TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1246&flavour=ld
#EXTINF:0,751 - Henan TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1247&flavour=ld
#EXTINF:0,752 - Guangdong TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1248&flavour=ld
#EXTINF:0,753 - Yunnan TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1249&flavour=ld
#EXTINF:0,754 - Hubei TV - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1250&flavour=hd
#EXTINF:0,755 - Sichuan TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1251&flavour=ld
#EXTINF:0,756 - Liaoning TV - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1252&flavour=hd
#EXTINF:0,756 - Liaoning TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1252&flavour=ld
#EXTINF:0,756 - Liaoning TV - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1252
#EXTINF:0,758 - CNTV-7 + Military and Agriculture - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1253&flavour=ld
#EXTINF:0,759 - CNTV-12 + Society and Law - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1254&flavour=ld
#EXTINF:0,760 - CNTV-2 Finance - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1255&flavour=ld
#EXTINF:0,761 - CGTN Espanol - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1256&flavour=ld
#EXTINF:0,762 - CGTN Arabic - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1257&flavour=ld
#EXTINF:0,763 - CGTN Russian - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1258&flavour=ld
#EXTINF:0,764 - CNTV-10 + Science and Education - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1259&flavour=ld
#EXTINF:0,765 - CNTV-14 + Children - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1260&flavour=ld
#EXTINF:0,766 - Macau Asia Satellite TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1261&flavour=ld
#EXTINF:0,767 - Ningxia TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1262&flavour=ld
#EXTINF:0,768 - Qinghai TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1263&flavour=ld
#EXTINF:0,769 - Guizhou TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1264&flavour=ld
#EXTINF:0,770 - Heilongjiang TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1265&flavour=ld
#EXTINF:0,771 - Shaanxi TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1266&flavour=ld
#EXTINF:0,772 - Chinese Kungfu - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1267&flavour=ld
#EXTINF:0,773 - China Education Television - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1268&flavour=ld
#EXTINF:0,774 - Documentary Channel - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1269
#EXTINF:0,774 - Documentary Channel - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1269&flavour=hd
#EXTINF:0,774 - Documentary Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1269&flavour=ld
#EXTINF:0,775 - Society & Law Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1270&flavour=ld
#EXTINF:0,775 - Society & Law Channel - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1270
#EXTINF:0,775 - Society & Law Channel - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1270&flavour=hd
#EXTINF:0,776 - Shandong Education Television - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1271&flavour=ld
#EXTINF:0,777 - Beijing TV Documentary - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1272
#EXTINF:0,777 - Beijing TV Documentary - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1272&flavour=hd
#EXTINF:0,777 - Beijing TV Documentary - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1272&flavour=ld
#EXTINF:0,779 - Southeast Television - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1273&flavour=ld
#EXTINF:0,780 - Chongqing TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1274&flavour=ld
#EXTINF:0,781 - Anhui TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1275&flavour=ld
#EXTINF:0,782 - Tianjin TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1276&flavour=ld
#EXTINF:0,783 - Shandong TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1277&flavour=ld
#EXTINF:0,784 - Shenzhen TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1278&flavour=ld
#EXTINF:0,785 - Hong Kong TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1279&flavour=ld
#EXTINF:0,785 - Hong Kong TV - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1279
#EXTINF:0,785 - Hong Kong TV - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1279&flavour=hd
#EXTINF:0,786 - One TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1280&flavour=ld
#EXTINF:0,787 - Liyuan Chinese Opera Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1281&flavour=ld
#EXTINF:0,788 - Wenzhou TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1282&flavour=ld
#EXTINF:0,789 - Cartoon Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1283&flavour=ld
#EXTINF:0,789 - Cartoon Channel - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1283
#EXTINF:0,789 - Cartoon Channel - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1283&flavour=hd
#EXTINF:0,790 - Entertainment Channel - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1284&flavour=hd
#EXTINF:0,790 - Entertainment Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1284&flavour=ld
#EXTINF:0,790 - Entertainment Channel - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1284
#EXTINF:0,791 - Boutique Drama Channel - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1285&flavour=hd
#EXTINF:0,791 - Boutique Drama Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1285&flavour=ld
#EXTINF:0,791 - Boutique Drama Channel - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1285
#EXTINF:0,792 - Palace TV - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1286
#EXTINF:0,792 - Palace TV - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1286&flavour=hd
#EXTINF:0,792 - Palace TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1286&flavour=ld
#EXTINF:0,793 - Panda Channel - CET (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1287&flavour=hd
#EXTINF:0,793 - Panda Channel - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1287&flavour=ld
#EXTINF:0,793 - Panda Channel - CET (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1287
#EXTINF:0,794 - Gansu TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1288&flavour=ld
#EXTINF:0,795 - Shanxi TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1289&flavour=ld
#EXTINF:0,796 - Guangxi TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1290&flavour=ld
#EXTINF:0,797 - Jiangxi TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1291&flavour=ld
#EXTINF:0,798 - Hebei TV - CET (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1292&flavour=ld
#EXTINF:0,799 - NTD Television (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=912&flavour=ld
#EXTINF:0,900 - Grand Lille TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=826
#EXTINF:0,900 - Grand Lille TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=826&flavour=hd
#EXTINF:0,900 - Grand Lille TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=826&flavour=ld
#EXTINF:0,901 - TV7 Bordeaux (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=268&flavour=sd
#EXTINF:0,902 - 8 Mont-Blanc (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=319&flavour=sd
#EXTINF:0,903 - TéléGrenoble (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=423&flavour=sd
#EXTINF:0,904 - vià Grand Paris (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=360&flavour=sd
#EXTINF:0,905 - ERE TV (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=363&flavour=sd
#EXTINF:0,906 - La Chaîne Normande (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1125&flavour=ld
#EXTINF:0,907 - Télénantes Nantes 7 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=389&flavour=sd
#EXTINF:0,908 - TV Tours (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=493&flavour=sd
#EXTINF:0,909 - TV Cristal (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1234
#EXTINF:0,909 - TV Cristal (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1234&flavour=hd
#EXTINF:0,909 - TV Cristal (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1234&flavour=ld
#EXTINF:0,910 - IDF 1 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=689&flavour=hd
#EXTINF:0,910 - IDF 1 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=689&flavour=sd
#EXTINF:0,910 - IDF 1 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=689
#EXTINF:0,911 - Locales Ile de France (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=756&flavour=sd
#EXTINF:0,912 - Alsace 20 (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=753&flavour=sd
#EXTINF:0,913 - TV Fil 78 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=855&flavour=ld
#EXTINF:0,914 - Wéo (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=832&flavour=sd
#EXTINF:0,915 - TLM (standard)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=267&flavour=sd
#EXTINF:0,917 - Canal 10 Guadeloupe (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=929&flavour=ld
#EXTINF:0,919 - vià30 Pays Gardois (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=880&flavour=ld
#EXTINF:0,920 - Mirabelle TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=907&flavour=ld
#EXTINF:0,921 - viàVosges (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=900&flavour=ld
#EXTINF:0,922 - vià34 Montpellier (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=930&flavour=ld
#EXTINF:0,923 - Maritima TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=951&flavour=ld
#EXTINF:0,924 - TV Vendée (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=964&flavour=ld
#EXTINF:0,926 - Grand Littoral TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1302&flavour=ld
#EXTINF:0,926 - Grand Littoral TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1302
#EXTINF:0,926 - Grand Littoral TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1302&flavour=hd
#EXTINF:0,927 - TVR (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1063&flavour=ld
#EXTINF:0,927 - TVR (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1063
#EXTINF:0,927 - TVR (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1063&flavour=hd
#EXTINF:0,928 - Tébésud (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1064
#EXTINF:0,928 - Tébésud (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1064&flavour=hd
#EXTINF:0,928 - Tébésud (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1064&flavour=ld
#EXTINF:0,929 - Tébéo (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1065&flavour=hd
#EXTINF:0,929 - Tébéo (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1065&flavour=ld
#EXTINF:0,929 - Tébéo (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1065
#EXTINF:0,930 - D!CI TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1066&flavour=ld
#EXTINF:0,931 - MFM TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1067
#EXTINF:0,931 - MFM TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1067&flavour=hd
#EXTINF:0,931 - MFM TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1067&flavour=ld
#EXTINF:0,932 - Télé Antilles (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1084&flavour=ld
#EXTINF:0,933 - TL7 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1108&flavour=ld
#EXTINF:0,934 - TVPI (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1107&flavour=ld
#EXTINF:0,935 - Azur TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1130&flavour=ld
#EXTINF:0,936 - vià66 Pays Catalan (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1235&flavour=ld
#EXTINF:0,937 - MaTélé (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1165&flavour=hd
#EXTINF:0,938 - Angers TV (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1174
#EXTINF:0,938 - Angers TV (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1174&flavour=hd
#EXTINF:0,938 - Angers TV (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1174&flavour=ld
#EXTINF:0,939 - Télé Bocal (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1220&flavour=ld
#EXTINF:0,942 - Vià31 (auto)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1303
#EXTINF:0,942 - Vià31 (HD)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1303&flavour=hd
#EXTINF:0,942 - Vià31 (bas débit)
rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=1303&flavour=ld
]]
