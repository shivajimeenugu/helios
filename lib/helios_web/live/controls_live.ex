defmodule HeliosWeb.ControlsLive do
  use HeliosWeb, :live_view

  def mount(_params, _session, socket) do
    # :ok = Phoenix.PubSub.subscribe(Helios.PubSub, "room:lobby")
    HeliosWeb.Endpoint.subscribe("room:lobby")
    [[
      id,
      peekWindowAngle,
      radioVolumeType,
      radioVolumeTrack,
      light,
      Peekwindow
      ]]=MyXQL.query!(:myxql, "SELECT * From controls").rows
    socket = assign(socket, :brightness, 10)
    socket = assign(socket, :peekWindowAngle, peekWindowAngle)
    socket = assign(socket, :radioVolumeType, radioVolumeType)
    socket = assign(socket, :radioVolumeTrack, radioVolumeTrack)
    socket = assign(socket, :light, light)
    socket = assign(socket, :light, Peekwindow)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="body bg-white h-full z-0">
    <div class="flex pl-5 pt-3 items-center">
        <div class="font-['heliosfont'] text-[40px] m-3">Light</div>
        <form phx-change="light">
        <div class="btn pt-5 m-3">

        <%= if @light=="on" do %>
            <label class=" relative inline-flex items-center mr-5 cursor-pointer">
            <input  type="checkbox" name="light"  class="sr-only peer" checked>
            <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
            <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
          </label>
      <% else %>
          <label class=" relative inline-flex items-center mr-5 cursor-pointer">
                  <input name="light" type="checkbox" class="sr-only peer" >
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
                  <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
                </label>
      <% end %>

        </div>
        </form>

    </div>

    <div class="flex ml-12 mt-2">
        <div class="w-3/12">
            <div class="w-16 h-16 rounded-full drop-shadow-2xl bg-yellow-100"></div>
        </div>
        <div class="w-9/12">
            <div class=""><input id="lightrange1" type="range" value="50" class="w-10/12 h-3  rounded appearance-none cursor-pointer bg-yellow-200"></div>
            <div class=""><input id="lightrange2" type="range" value="50" class="w-10/12 h-3  rounded-lg appearance-none cursor-pointer bg-gray-100"></div>
            <div class=""><input id="lightrange3" type="range" value="50" class="w-10/12 h-3  rounded-lg appearance-none cursor-pointer bg-blue-200"></div>
        </div>
    </div>

    <form phx-change="Peekwindow">
    <div class="flex justify-start pt-3 pl-5 w-9/12">
        <div class="font-['heliosfont'] text-[160%] pt-3">Peek-window</div>
        <div class="pt-6 pl-6">
            <label class=" relative inline-flex items-center mr-5 cursor-pointer">
            <input type="checkbox" name="Peekwindow" class="sr-only peer" checked>
            <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
            <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
          </label>
        </div>
    </div>
    </form>

    <div class="flex pt-3 pl-5 h-auto  items-center">
        <div class="w-9/12">
        <form phx-change="peekWindowAngle">
        <input  class="w-11/12 h-3 rounded appearance-none cursor-pointer bg-yellow-200" id="peekWindowAngle1"  name="peekWindowAngle" type="range" value={"#{@peekWindowAngle}"}  />
        </form>
        </div>
        <div class="w-6/12 flex h-full items-center">
            <div class="mr-1 ml-1 font-['heliosfont'] pb-2 text-[25px] ">Angle</div>
            <div class="border ml-1 text-center font-['heliosfont'] text-gray-500 border-gray-600 border-1 rounded-md w-[30%]"> <%= @peekWindowAngle %> </div>
        </div>
    </div>


    <div class="flex justify-start pt-3 pl-5 w-9/12">
        <div class="font-['heliosfont'] text-[160%] pt-3">Speakers</div>
        <div class="pt-6 pl-6">
            <label class=" relative inline-flex items-center mr-5 cursor-pointer">
            <input type="checkbox" value="" class="sr-only peer" checked>
            <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
            <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
          </label>
        </div>
    </div>

    <div class="">
        <div class="flex items-center pl-7">
            <div class="flex w-[19%]"><img src="./images/speaker.png" alt="" srcset=""></div>
            <div class="font-['heliosfont'] ml-2 text-[200%]">Volume</div>
        </div>
        <div class="pl-5 pt-2 w-10/12">
            <div class=""><input id="Volume" type="range" value="50" class="w-10/12 h-3  rounded appearance-none cursor-pointer bg-yellow-200"></div>
        </div>
    </div>


    <div class="flex pl-5 pt-1 justify-evenly">

        <div class="rounded-xl border border-2 border-yellow-300 w-5/12">

        <form phx-change="radioVolumeType">
            <div class="radio-toolbar p-2 flex flex-col ">

            <%= if @radioVolumeType=="Bluetooth" do %>
              <input class="" type="radio" id="radioBluetooth" name="radioVolumeType"   value="Bluetooth"  checked>
              <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioBluetooth">Bluetooth <svg fill="#CCCC00" class="flex w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"> <g> <path fill="none" d="M0 0h24v24H0z"/> <path d="M14.341 12.03l4.343 4.343-5.656 5.656h-2v-6.686l-4.364 4.364-1.415-1.414 5.779-5.778v-.97L5.249 5.765l1.415-1.414 4.364 4.364V2.029h2l5.656 5.657-4.343 4.343zm-1.313 1.514v5.657l2.828-2.828-2.828-2.829zm0-3.03l2.828-2.828-2.828-2.828v5.657zM19.5 13.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm-13 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/> </g> </svg></label>
            <% else %>
            <input class="" type="radio" id="radioBluetooth" name="radioVolumeType"   value="Bluetooth"  >
            <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioBluetooth">Bluetooth <svg fill="#CCCC00" class="flex w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"> <g> <path fill="none" d="M0 0h24v24H0z"/> <path d="M14.341 12.03l4.343 4.343-5.656 5.656h-2v-6.686l-4.364 4.364-1.415-1.414 5.779-5.778v-.97L5.249 5.765l1.415-1.414 4.364 4.364V2.029h2l5.656 5.657-4.343 4.343zm-1.313 1.514v5.657l2.828-2.828-2.828-2.829zm0-3.03l2.828-2.828-2.828-2.828v5.657zM19.5 13.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm-13 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/> </g> </svg></label>
            <% end %>


            <%= if @radioVolumeType=="Aux" do %>
                <input type="radio" id="radioAux" name="radioVolumeType" value="Aux" checked>
                <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioAux">Aux</label>
            <% else %>
                <input type="radio" id="radioAux" name="radioVolumeType" value="Aux">
                <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioAux">Aux</label>
            <% end %>

            <%= if @radioVolumeType=="TV" do %>
                <input type="radio" id="radioTV" name="radioVolumeType" value="TV" checked>
                <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioTV">T.V.</label>
            <% else %>
                <input type="radio" id="radioTV" name="radioVolumeType" value="TV">
                <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioTV">T.V.</label>
            <% end %>

            <%= if @radioVolumeType=="Network" do %>
                <input type="radio" id="radioNetwork" name="radioVolumeType" value="Network" checked>
                <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioNetwork">Network</label>
            <% else %>
                <input type="radio" id="radioNetwork" name="radioVolumeType" value="Network">
                <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioNetwork">Network</label>
            <% end %>






            </div>
          </form>
        </div>

        <div class=" w-5/12 ">
            <div class="font-['heliosfont']">Choose track</div>
            <div class="rounded-xl border border-2 border-yellow-300 ">
            <form phx-change="radioVolumeTrack">
            <div class="radio-toolbar p-2 flex flex-col ">

               <%= if @radioVolumeTrack=="Forest" do %>
                <input class="" type="radio" id="radioForest" name="radioVolumeTrack" value="Forest" checked>
                <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioForest">Forest</label>
               <% else %>
               <input class="" type="radio" id="radioForest" name="radioVolumeTrack" value="Forest" >
               <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioForest">Forest</label>
               <% end %>

               <%= if @radioVolumeTrack=="Sea" do %>
               <input type="radio" id="radioSea" name="radioVolumeTrack" value="Sea" checked>
               <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioSea">Sea</label>
               <% else %>
               <input type="radio" id="radioSea" name="radioVolumeTrack" value="Sea">
               <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioSea">Sea</label>
               <% end %>

               <%= if @radioVolumeTrack=="City" do %>
               <input type="radio" id="radioCity" name="radioVolumeTrack" value="City" checked>
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioCity">City</label>
               <% else %>
               <input type="radio" id="radioCity" name="radioVolumeTrack" value="City">
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioCity">City</label>
               <% end %>


               <%= if @radioVolumeTrack=="Mountain" do %>
               <input type="radio" id="radioMountain" name="radioVolumeTrack" value="Mountain" checked>
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioMountain">Mountain</label>
               <% else %>
               <input type="radio" id="radioMountain" name="radioVolumeTrack" value="Mountain">
                    <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radioMountain">Mountain</label>
               <% end %>




                </div>
                </form>
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

    # HeliosWeb.Endpoint.broadcast("room:lobby", "peekWindowAngle", %{data: d["peekWindowAngle"]})
    {:noreply, socket}
  end




  def handle_event("Peekwindow",d, socket) do
    socket = assign(socket, :Peekwindow, d["Peekwindow"])
    res=MyXQL.query!(:myxql, "Update controls set Peekwindow=#{d["Peekwindow"]} where id=1")
    IO.inspect(res)
    IO.inspect(d["Peekwindow"])
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "Peekwindow", %{data: d["Peekwindow"]})
    # HeliosWeb.Endpoint.broadcast("room:lobby", "peekWindowAngle", %{data: d["peekWindowAngle"]})
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


  # %Phoenix.Socket.Broadcast{
  #   event: "peekWindowAngle",
  #   payload: %{data: "29"},
  #   topic: "room:lobby"
  # }
  def handle_info(data, socket) do
    # IO.inspect("from controls live view")
    # IO.inspect(data)
    socket= cond do
        data.event == "shout" ->
          IO.puts("[LiveView] shout")
          new = 20
          socket = assign(socket, :brightness, new)
          socket
        data.event == "peekWindowAngle" ->
          IO.puts("[LiveView][handle_info] peekWindowAngle updated")
          socket = assign(socket, :peekWindowAngle,data.payload["data"])
          socket
          data.event == "light" ->
            IO.puts("[LiveView][handle_info] light updated")
            socket = assign(socket, :light,data.payload["light"])
            socket

        true ->
          socket
      end

    {:noreply, socket}
  end

end
