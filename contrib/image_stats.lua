--[[
    This file is part of darktable,
    copyright 2016 by Christian Kanzian.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

--[[
   IMAGE STATS PLOTS SUMMARIZE YOUR SHOOTING HABITS
   This script is inspired by the focalanalyzer.sh for digiKam. 

REQUIREMENDS
 *

INSTALATION
 * copy this file in $CONFIGDIR/lua/ where CONFIGDIR is your darktable configuration directory
 * add the following line in the file $CONFIGDIR/luarc require "image_stats"


USAGE
 * TODO 

TODO
 * write first working sample
 * future add grouping feature
 *

]]

local dt = require "darktable"
dt.configuration.check_version(...,{4,0,0})

-- define with exif data to plot
local exif_types_sel = { 
  exif_focal_length = "focal length",
  exif_aperture = "aperture",
  exif_exposure = "exposure",
  exif_iso = "iso"
  }

  
local sel_type = "exif_focal_length"


-- function to collect specific exif data from action images
local function get_exif(et)
  
  local sel_images = dt.gui.action_images
  
  image_exif = {}

  for k,image in ipairs(sel_images) do
      image_exif[k] = image.exif_focal_length
    end

    return(image_exif)
  end

 
--frequency calculation

local function frequency(t)
  local freq = {}
  
  for _,v in ipairs(t) do
    freq[v] = (freq[v] or 0) + 1
  end
 return(freq)
end


local function dump(t)
  for k,v in pairs(t) do
    print(k,v)
  end
end


local function plot_stats()
    
  local ttab = get_exif(sel_type)

   dump(frequency(ttab))
 end
 

-- create modul

dt.register_lib("image_statistics","plot image statistics",true,false,{
    [dt.gui.views.lighttable] = {"DT_UI_CONTAINER_PANEL_LEFT_BOTTOM",500}
    },
    dt.new_widget("box")
    {
      orientation = "vertical",
       dt.new_widget("button")
       {
         label = "plot statistics",
         clicked_callback = plot_stats 
       },
    },
   nil,
   nil
  )

-- vim: shiftwidth=2 expandtab tabstop=2 cindent syntax=lua
-- kate: tab-indents: off; indent-width 2; replace-tabs on; remove-trailing-space on;
