--[[
	Mike 2018	
	I've mashed a few scripts together and come up with this so far. Not too shabby coming from a guy who pours concrete for a living!

	Script has clock and status rings. Also, indicator ring will change from default color to any color you wish using whatever 'warn= or crit=' 		number you desire. Give it a try for yourself. Easiest way is to change any 'warn_=number' (i.e. Default: warn_disk=75. Change it to =1 and 
	reload your conky. 

	Enjoy!
]]

--Stole this from rings-v1.3.1.lua---Using these as watch indicator colors
normal="0x5e97f2" --default bluish
warn="0xffff00" --yellowish
crit="0xff0000" --red


settings_table = {
    {
        -- Edit this table to customise your rings.
        -- You can create more rings simply by adding more elements to settings_table.
        -- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc', etc....
        name='time',
        -- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
        arg='%I.%M',
        -- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
        max=12,
        -- "bg_colour" is the colour of the base ring.
        bg_colour=0xc0c5ce,
        -- "bg_alpha" is the alpha value of the base ring.
        bg_alpha=0.3,
        -- "fg_colour" is the colour of the indicator part of the ring.
        fg_colour=0x5e97f2,
        -- "fg_alpha" is the alpha value of the indicator part of the ring.
        fg_alpha=0.6,
        -- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
        x=130, y=200,
        -- "radius" is the radius of the ring.
        radius=50,
        -- "thickness" is the thickness of the ring, centred around the radius.
        thickness=5,
        -- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
        start_angle=0,
        -- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger than start_angle.
        end_angle=360
    },


    {
        name='time',
        arg='%M.%S',
        max=60,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.6,
        x=130, y=200,
        radius=66,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%S',
        max=60,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.5,
        x=130, y=200,
        radius=72,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
   {
        name='cpu',
        arg='cpu1',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=32, y=360,
        radius=26,
        thickness=5,
        start_angle=-180,
        end_angle=180
    },
   {
        name='cpu',
        arg='cpu2',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=98, y=360,
        radius=25,
        thickness=5,
        start_angle=-180,
        end_angle=180
    },
   {
        name='cpu',
        arg='cpu3',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=167, y=360,
        radius=25,
        thickness=5,
        start_angle=-180,
        end_angle=180
    },
   {
        name='cpu',
        arg='cpu4',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=230, y=360,
        radius=25,
        thickness=5,
        start_angle=-180,
        end_angle=180
    },
   {
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.3,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=40, y=520,
        radius=27,
        thickness=5,
        start_angle=-90,
        end_angle=145
    },
   {
        name='memperc',
        arg='',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.2,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
        x=130, y=520,
        radius=27,
        thickness=5,
        start_angle=-90,
        end_angle=145
    },
    {
        name='fs_used_perc',
        arg='/mnt/data',
        max=100,
        bg_colour=0xc0c5ce,
        bg_alpha=0.2,
        fg_colour=0x5e97f2,
        fg_alpha=0.8,
x=220, y=520,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=145
    },
}

-- Use these settings to define the origin and extent of your clock.

clock_r=65

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

clock_x=130
clock_y=200

show_seconds=true -- Change to true if you want the seconds hand




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
	    
    	    draw_clock_hands(cr,clock_x,clock_y)
	    disk_watch()
    	    cpu_watch()
	    ram_watch()

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

function draw_clock_hands(cr,xc,yc)
    local secs,mins,hours,secs_arc,mins_arc,hours_arc
    local xh,yh,xm,ym,xs,ys
    
    secs=os.date("%S")    
    mins=os.date("%M")
    hours=os.date("%I")
        
    secs_arc=(2*math.pi/60)*secs
    mins_arc=(2*math.pi/60)*mins+secs_arc/60
    hours_arc=(2*math.pi/12)*hours+mins_arc/12
        
    -- Draw hour hand
    
    xh=xc+0.76*clock_r*math.sin(hours_arc)
    yh=yc-0.72*clock_r*math.cos(hours_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xh,yh)
    
    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,5)
    cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
    cairo_stroke(cr)
    
    -- Draw minute hand
    
    xm=xc+0.98*clock_r*math.sin(mins_arc)
    ym=yc-1.02*clock_r*math.cos(mins_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xm,ym)
    
    cairo_set_line_width(cr,3)
    cairo_stroke(cr)
    
    -- Draw seconds hand
    
    if show_seconds then
        xs=xc+1.1*clock_r*math.sin(secs_arc)
        ys=yc-clock_r*math.cos(secs_arc)
        cairo_move_to(cr,xc,yc)
        cairo_line_to(cr,xs,ys)
    
        cairo_set_line_width(cr,1)
        cairo_stroke(cr)
    end
end

    -- Disk Usage Warning
function disk_watch()

    local warn_disk=75
    local crit_disk=90

    disk=tonumber(conky_parse("${fs_used_perc /}"))

    if disk<warn_disk then
        settings_table[8]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[8]['fg_colour']=warn
    else
        settings_table[8]['fg_colour']=crit
    end

    disk=tonumber(conky_parse("${fs_used_perc /mnt/data}"))

    if disk<warn_disk then
        settings_table[10]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[10]['fg_colour']=warn
    else
        settings_table[10]['fg_colour']=crit
    end

end

	--CPU Usage Warning
function cpu_watch()

    local warn_cpu=65
    local crit_cpu=90

    cpu=tonumber(conky_parse("${cpu cpu1}"))

    if cpu<warn_cpu then
        settings_table[4]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[4]['fg_colour']=warn
    else
        settings_table[4]['fg_colour']=crit
    end

    cpu=tonumber(conky_parse("${cpu cpu2}"))

    if cpu<warn_cpu then
        settings_table[5]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[5]['fg_colour']=warn
    else
        settings_table[5]['fg_colour']=crit
    end

    cpu=tonumber(conky_parse("${cpu cpu3}"))

    if cpu<warn_cpu then
        settings_table[6]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[6]['fg_colour']=warn
    else
        settings_table[6]['fg_colour']=crit
    end

    cpu=tonumber(conky_parse("${cpu cpu4}"))

    if cpu<warn_cpu then
        settings_table[7]['fg_colour']=normal
    elseif cpu<crit_cpu then
        settings_table[7]['fg_colour']=warn
    else
        settings_table[7]['fg_colour']=crit
    end

end

	--RAM Usage Warning
function ram_watch()
	
    local warn_ram=80
    local crit_ram=95

    ram=tonumber(conky_parse("${memperc}"))

    if ram<warn_ram then
        settings_table[9]['fg_colour']=normal
    elseif ram<crit_ram then
        settings_table[9]['fg_colour']=warn
    else
        settings_table[9]['fg_colour']=crit
    end

end


    
    





