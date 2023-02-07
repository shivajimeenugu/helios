defmodule HeliosWeb.FeaturesLive do
  use HeliosWeb, :live_view

  def mount(_params, _session, socket) do
    HeliosWeb.Endpoint.subscribe("room:lobby")
    [[
      id,
      peekWindowAngle,
      radioVolumeType,
      radioVolumeTrack,
      light
      ]]=MyXQL.query!(:myxql, "SELECT * From controls").rows
    socket = assign(socket, :brightness, 10)
    socket = assign(socket, :peekWindowAngle, peekWindowAngle)
    socket = assign(socket, :radioVolumeType, radioVolumeType)
    socket = assign(socket, :radioVolumeTrack, radioVolumeTrack)
    socket = assign(socket, :light, light)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="body bg-white h-full z-0">

    <div class="flex justify-start pl-5 pt-3 items-center font-['heliosfont'] text-[25px] ">
    Ventilation
</div>

<div class="flex items-center justify-evenly ">
    <div class=""><img src="/images/fan.png" alt="" srcset=""></div>
    <div class="font-['heliosfont'] text-[25px]">Fan Speed</div>
    <div class="pt-3">
        <label class=" relative inline-flex items-center mr-5 cursor-pointer">
            <input type="checkbox" value="" class="sr-only peer" checked>
            <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
            <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
          </label>
    </div>
</div>

<div class="pl-10">
    <input id="fanSpeed" name="fanSpeed" type="range" value="50" class="w-10/12 h-3  rounded appearance-none cursor-pointer bg-yellow-200">
</div>

<div class="">
    <div class="flex justify-start pl-5 pt-3 items-center font-['heliosfont'] text-[25px] ">Scents</div>
    <div class="flex pl-7">
        <div class="flex flex-col w-8/12 ">
            <div class="flex items-center">
                <div class="flex items-center">
                    <select class="hselect font-['heliosfont']" name="" id="" >
                        <option value="Choose Scent">Choose Scents</option>
                        <option value="Lavender">Lavender</option>
                        <option value="Lime">Lime</option>
                        <option value="Rose">Rose</option>
                        <option value="Salty">Salty</option>
                    </select>
                    <i class="fa fa-angle-down pt-2 ml-1"></i>
                    <!-- <i class="fa fa-angle-up pt-2 ml-1"></i> -->
                </div>
                <div class="flex w-[40%] ml-5"><img src="/images/perfume-bottle.png" alt="" srcset=""></div>
            </div>
            <div class="flex justify-center mt-5">
                <button class="w-[55%] text-[180%] bg-yellow-300 rounded-xl p-2 font-['heliosfont'] text-center">Press</button>
            </div>
        </div>
        <div class=" w-4/12 flex flex-col justify-center items-center">
            <div class="font-['heliosfont']">Time</div>
            <div class="rounded-xl w-fit border border-2 border-yellow-300 ">
                <div class="radio-toolbar p-2 flex flex-col ">
                    <input class="" type="radio" id="radioForest" name="radioVolumeTrack" value="Forest" checked>
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioForest">1 Sec</label>

                    <input type="radio" id="radioSea" name="radioVolumeTrack" value="Sea">
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioSea">2 Sec</label>

                    <input type="radio" id="radioCity" name="radioVolumeTrack" value="City">
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioCity">3 sec</label>

                    <input type="radio" id="radioMountain" name="radioVolumeTrack" value="Mountain">
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioMountain">4 sec</label>

                    <input type="radio" id="radioMountain" name="radioVolumeTrack" value="Mountain">
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioMountain">5 sec</label>

                </div>
            </div>
        </div>
    </div>
</div>

<div class="">
    <div class="flex justify-start pl-5 pt-3 items-center font-['heliosfont'] text-[25px] ">
        WiFi Socket
    </div>
    <div class="flex items-center  justify-start">
        <div class="flex  w-6/12">
            <img class="h-[40%] " src="./images/1675585349684.png" alt="" srcset="">
        </div>

        <div class="items-center  w-6/12 ml-5">
            <label class="  relative inline-flex items-center mr-5 cursor-pointer">
                <input type="checkbox" value="" class="sr-only peer" checked>
                <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
                <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
              </label>
        </div>
    </div>
</div>

    </div>


  """
  end

  # def handle_event("on2", %{"peekWindowAngle1" => angle}, socket) do
  #   HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "e", %{data: "hi"})
  #   {:noreply, assign(socket, :peekWindowAngle, angle)}
  # end

  def handle_event("peekWindowAngle",d, socket) do
    socket = assign(socket, :peekWindowAngle, d["peekWindowAngle"])
    res=MyXQL.query!(:myxql, "Update controls set peekWindowAngle=#{d["peekWindowAngle"]} where id=1")
    IO.inspect(res)
    IO.inspect(d["peekWindowAngle"])
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "peekWindowAngle", %{data: d["peekWindowAngle"]})
    {:noreply, socket}
  end

  def handle_event("radioVolumeType",d, socket) do
    socket = assign(socket, :radioVolumeType, d["radioVolumeType"])
    res=MyXQL.query!(:myxql, "Update controls set radioVolumeType = '#{d["radioVolumeType"]}' where id=1")
    IO.inspect(d["radioVolumeType"])
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "radioVolumeType", %{data: d["radioVolumeType"]})
    {:noreply, socket}
  end

  def handle_event("radioVolumeTrack",d, socket) do
    socket = assign(socket, :radioVolumeTrack, d["radioVolumeTrack"])
    res=MyXQL.query!(:myxql, "Update controls set radioVolumeTrack='#{d["radioVolumeTrack"]}' where id=1")
    IO.inspect(d["radioVolumeTrack"])
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "radioVolumeTrack", %{data: d["radioVolumeTrack"]})
    {:noreply, socket}
  end

  def handle_event("light", d, socket) do
    # Handle the toggle event here
    IO.inspect(d)
    socket = assign(socket, :light, d["light"])
    res=MyXQL.query!(:myxql, "Update controls set light='#{d["light"]}' where id=1")
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "light", %{data: d["light"]})
    {:noreply, socket}
  end

  def handle_info(data, socket) do
    y_pos = %{a: 1, b: 2, c: 3, d: 4, e: 5, f: 6}
    socket= cond do
        data.event == "shout" ->
          IO.puts("[LiveView] shout")
          new = 20
          socket = assign(socket, :brightness, new)
          socket

        true ->
          socket
      end

    {:noreply, socket}
  end


end
