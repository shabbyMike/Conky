--Watch indicator colors
normal='0x5e97f2' --default bluish
warn='0xffff00' --yellow
crit='0xff0000' --red

settings_table = {
    
	--[[ Edit this table to customise your rings. You can create more rings simply by adding more elements to settings_table.
		- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc', etc....
		- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. 
		     If you would not use an argument in the Conky variable, use ''.
		- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
		- "bg_colour" is the colour of the base ring.
		- "bg_alpha" is the alpha value of the base ring.
		- "fg_colour" is the colour of the indicator part of the ring.
		- "fg_alpha" is the alpha value of the indicator part of the ring.
		- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
		- "radius" is the radius of the ring.
		- "thickness" is the thickness of the ring, centred around the radius.
		- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
		- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, 
		     but must be larger than start_angle.
	]]
	
   {
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=419, y=90,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='memperc',
        arg='',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=510, y=90,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='fs_used_perc',
        arg='/mnt/data',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=601, y=90,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='hwmon 1',
        arg='temp 1',
        max=80,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=692, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='cpu',
        arg='cpu1',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=762, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='cpu',
        arg='cpu2',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=832, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='cpu',
        arg='cpu3',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=902, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='cpu',
        arg='cpu4',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=972, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='nvidia',
        arg='temp',
        max=105,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=48, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='nvidia',
        arg='gpuutil',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=118, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='nvidia',
        arg='membwutil',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=188, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='nvidia',
        arg='pcieutil',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=258, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
   {
        name='nvidia',
        arg='videoutil',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=328, y=40,
        radius=28,
        thickness=6,
        start_angle=-90,
        end_angle=145
    },
}

require 'cairo'

function conky_main()
    local function setup_rings(cr,pt)
	local str=''
        local value=0
        
        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)
        
        value=tonumber(str)
        pct=value/pt['max']
        
        draw_ring(cr,pct,pt)
    end
        -- Check that Conky has been running for at least 5s

    if conky_window==nil then return end
    	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    
    	local cr=cairo_create(cs)    
    
    	local updates=conky_parse('${updates}')
   	 update_num=tonumber(updates)
    
   	 if update_num>5 then
       		 for i in pairs(settings_table) do
	    	 setup_rings(cr,settings_table[i])

	 	 end
	    
    	    disk_watch()
    	    cpu_watch()
	        ram_watch()
            temp_watch()

    	 end 

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil

end


function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function window_background(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height
    
    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

-- Draw background ring
    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)
    
-- Draw indicator ring
    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)        
end

-- Disk Usage Warning
function disk_watch()

    local warn_disk=75
    local crit_disk=90

    disk=tonumber(conky_parse("${fs_used_perc /}"))

    if disk<warn_disk then
        settings_table[1]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[1]['fg_colour']=warn
    else
        settings_table[1]['fg_colour']=crit
    end

    disk=tonumber(conky_parse("${fs_used_perc /mnt/data}"))

    if disk<warn_disk then
        settings_table[3]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[3]['fg_colour']=warn
    else
        settings_table[3]['fg_colour']=crit
    end

end

--CPU Usage Warning
function cpu_watch()

    local warn_cpu=65
    local crit_cpu=90

    cpu=tonumber(conky_parse("${cpu cpu1}"))

    if cpu<warn_cpu then
        settings_table[5]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[5]['fg_colour']=warn
    else
        settings_table[5]['fg_colour']=crit
    end

    cpu=tonumber(conky_parse("${cpu cpu2}"))

    if cpu<warn_cpu then
        settings_table[6]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[6]['fg_colour']=warn
    else
        settings_table[6]['fg_colour']=crit
    end

    cpu=tonumber(conky_parse("${cpu cpu3}"))

    if cpu<warn_cpu then
        settings_table[7]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[7]['fg_colour']=warn
    else
        settings_table[7]['fg_colour']=crit
    end

    cpu=tonumber(conky_parse("${cpu cpu4}"))

    if cpu<warn_cpu then
        settings_table[8]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[8]['fg_colour']=warn
    else
        settings_table[8]['fg_colour']=crit
    end
    
end

--CPU Temp Warning
function temp_watch()

    local warn_temp=40
    local crit_temp=60
    
    temp=tonumber(conky_parse("${hwmon 1 temp 1}"))

    if temp<warn_temp then
        settings_table[4]['fg_colour']=normal
    elseif temp<crit_temp then
        settings_table[4]['fg_colour']=warn
    else
        settings_table[4]['fg_colour']=crit
    end

end

--RAM Usage Warning
function ram_watch()
	
    local warn_ram=80
    local crit_ram=95

    ram=tonumber(conky_parse("${memperc}"))

    if ram<warn_ram then
        settings_table[2]['fg_colour']=normal
    elseif ram<crit_ram then
        settings_table[2]['fg_colour']=warn
    else
        settings_table[2]['fg_colour']=crit
    end

end