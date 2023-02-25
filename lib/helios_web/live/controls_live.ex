defmodule HeliosWeb.ControlsLive do
  use HeliosWeb, :live_view
  require Poison

  def encode_map(map) do
    Poison.encode(map)
  end

  def decode_map(map) do
    Poison.decode(map, as_map: true)
  end

  def mount(_params, _session, socket) do
    # :ok = Phoenix.PubSub.subscribe(Helios.PubSub, "room:lobby")
    HeliosWeb.Endpoint.subscribe("room:lobby")
    data=MyXQL.query!(:myxql, "SELECT * From controls").rows

    [[
      id,
      light,
      slider,
      sent,
      fan,
      radioVolumeType,
      radioVolumeTrack,
      wifi
      ]]=data


    {:ok,slider} = decode_map(slider)
    {:ok,sent} = decode_map(sent)

    IO.inspect([[
      id,
      light,
      slider,
      sent,
      fan,
      radioVolumeType,
      radioVolumeTrack,
      wifi
      ]])

    socket = assign(socket, :light, light)

    socket = assign(socket, :slider1, slider["slider1"])
    socket = assign(socket, :slider2, slider["slider1"])
    socket = assign(socket, :slider3, slider["slider1"])

    socket = assign(socket, :sent_name, sent["sent_name"])
    socket = assign(socket, :sent_time, sent["sent_time"])

    socket = assign(socket, :fan, fan)

    socket = assign(socket, :radioVolumeType, radioVolumeType)
    socket = assign(socket, :radioVolumeTrack, radioVolumeTrack)

    socket = assign(socket, :wifi, wifi)


    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="body bg-white h-full z-0">
    <!--Light-->
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
  <!--Light End-->

  <!--Sliders-->
      <div class="flex ml-12 mt-2">
          <div class="w-3/12">
              <div class="w-16 h-16 rounded-full drop-shadow-2xl bg-yellow-100"></div>
          </div>
          <div class="w-9/12">
              <form phx-change="slider">
                <div class=""><input name="slider1" value={"#{@slider1}"} id="slider1" type="range"  class="w-10/12 h-3  rounded appearance-none cursor-pointer bg-yellow-200"></div>
                <div class=""><input name="slider2" value={"#{@slider2}"} id="slider2" type="range"  class="w-10/12 h-3  rounded-lg appearance-none cursor-pointer bg-gray-100"></div>
                <div class=""><input name="slider3" value={"#{@slider3}"} id="slider3" type="range"  class="w-10/12 h-3  rounded-lg appearance-none cursor-pointer bg-blue-200"></div>
              </form>
          </div>

      </div>
  <!--Sliders End-->









  <!--Sents-->
  <div class="">
      <div class="flex justify-start pl-5 pt-3 items-center font-['heliosfont'] text-[25px] ">Scents</div>
      <form phx-submit="sents_form">
      <div class="flex pl-7">
          <div class="flex flex-col w-8/12 ">
              <div class="flex items-center">
                  <div class="flex items-center">
                      <select name="sent_name" class="hselect font-['heliosfont']"  id="sent_name" >
                          <option value="Choose Scent" >Choose Scents</option>
                          <option  value="Lavender"  selected = {if @sent_name == "Lavender" do true else false end} > Lavender </option>
                          <option value="Lime" selected = {if @sent_name == "Lime" do true else false end} >Lime</option>
                          <option value="Rose" selected = {if @sent_name == "Rose" do true else false end} >Rose</option>
                          <option value="Salty" selected = {if @sent_name == "Salty" do true else false end}>Salty</option>
                      </select>
                      <i class="fa fa-angle-down pt-2 ml-1"></i>
                      <!-- <i class="fa fa-angle-up pt-2 ml-1"></i> -->
                  </div>
                  <div class="flex w-[40%] ml-5"><img src="./images/perfume-bottle.png" alt="" srcset=""></div>
              </div>
              <div class="flex justify-center mt-5">
                  <button type="submit" class="w-[55%] text-[180%] bg-yellow-300 rounded-xl p-2 font-['heliosfont'] text-center">Press</button>
              </div>
          </div>
          <div class=" w-4/12 flex flex-col justify-center items-center">
              <div class="font-['heliosfont']">Time</div>
              <div class="rounded-xl w-fit border border-2 border-yellow-300 ">
                  <div class="radio-toolbar p-2 flex flex-col ">
                      <input class="" type="radio" id="radio1sec" name="sent_time" value="1" checked = {if @sent_time == "1" do true else false end}>
                      <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radio1sec">1 Sec</label>

                      <input type="radio" id="radio2sec" name="sent_time" value="2" checked = {if @sent_time == "2" do true else false end}>
                      <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radio2sec">2 Sec</label>

                      <input type="radio" id="radio3sec" name="sent_time" value="3" checked = {if @sent_time == "3" do true else false end}>
                      <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radio3sec">3 sec</label>

                      <input type="radio" id="radio4sec" name="sent_time" value="4" checked = {if @sent_time == "4" do true else false end}>
                      <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radio4sec">4 sec</label>

                      <input type="radio" id="radio5sec" name="sent_time" value="5" checked = {if @sent_time == "5" do true else false end}>
                      <label class="rounded pl-1 pr-1 pt-1 items-center font-['heliosfont'] flex" for="radio5sec">5 sec</label>

                  </div>
              </div>
          </div>
      </div>
      </form>
  </div>
  <!--Sents End-->

  <!--Ventilation Start-->
  <div class="">
      <div class="flex justify-start pl-5 pt-3 items-center font-['heliosfont'] text-[25px] ">
          Ventilation
      </div>

      <div class="flex items-center justify-evenly ">
          <div class=""><img src="./images/fan.png" alt="" srcset=""></div>
          <div class="font-['heliosfont'] text-[25px]">Fan Speed</div>
          <div class="pt-3">
          <form phx-change="fan">
              <label class=" relative inline-flex items-center mr-5 cursor-pointer">
                  <input type="checkbox" name="fan" class="sr-only peer" checked = {if @fan == "on" do true else false end} >
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
                  <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
                </label>
          </form>
          </div>
      </div>

      <div class="pl-10">
          <input id="fanSpeed" name="fanSpeed" type="range" value="50" class="w-10/12 h-3  rounded appearance-none cursor-pointer bg-yellow-200">
      </div>

  </div>
  <!--Ventilation End-->

  <!--Choose Track and Audio Mode-->
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
  <!--Choose Track and Audio Mode End-->

  <!--WiFi Socket-->
  <div class="">
      <div class="flex justify-start pl-5 pt-3 items-center font-['heliosfont'] text-[25px] ">
          WiFi Socket
      </div>
      <div class="flex items-center  justify-start">
          <div class="flex  w-6/12">
              <img class="h-[40%] " src="./images/1675585349684.png" alt="" srcset="">
          </div>

          <div class="items-center  w-6/12 ml-5">
          <form phx-change="wifi">
              <label class="  relative inline-flex items-center mr-5 cursor-pointer">
                  <input name="wifi" type="checkbox" class="sr-only peer" checked = {if @wifi == "on" do true else false end}>
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-focus:ring-4 peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-green-600"></div>
                  <!-- <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Green</span> -->
                </label>
          </form>
          </div>
      </div>
  </div>
  <!--WiFi Socket End-->

    </div>

  """
  end



  def handle_event("light", d, socket) do
    # Handle the toggle event here
    IO.inspect(d)
    socket = assign(socket, :light, d["light"])
    res=MyXQL.query!(:myxql, "Update controls set light='#{d["light"]}' where id=1")
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "light", %{data: d["light"]})
    {:noreply, socket}
  end



  def handle_event("slider",d, socket) do
    # socket = assign(socket, :peekWindowAngle, d["peekWindowAngle"])
    socket = assign(socket, :slider1, d["slider1"])
    socket = assign(socket, :slider2, d["slider2"])
    socket = assign(socket, :slider3, d["slider3"])
    {:ok,s}=encode_map(d)
    res=MyXQL.query!(:myxql, "Update controls set slider='#{s}' where id=1")
    IO.inspect(d)
    # IO.inspect(d["peekWindowAngle"])

    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "slider", %{data: d})
    {:noreply, socket}
  end


  def handle_event("sents_form",d, socket) do
    IO.inspect(d)
    socket = assign(socket, :sent_name, d["sent_name"])
    socket = assign(socket, :sent_time, d["sent_time"])

    {:ok,s}=encode_map(d)
    res=MyXQL.query!(:myxql, "Update controls set sent='#{s}' where id=1")

    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "sent", %{data: d})
    {:noreply, socket}
  end

  def handle_event("fan", d, socket) do
    # Handle the toggle event here
    IO.inspect(d)
    socket = assign(socket, :fan, d["fan"])
    res=MyXQL.query!(:myxql, "Update controls set fan='#{d["fan"]}' where id=1")
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "fan", %{data: d["fan"]})
    {:noreply, socket}
  end

  def handle_event("radioVolumeType",d, socket) do
    IO.inspect(d)
    socket = assign(socket, :radioVolumeType, d["radioVolumeType"])
    res=MyXQL.query!(:myxql, "Update controls set radioVolumeType = '#{d["radioVolumeType"]}' where id=1")
    # IO.inspect(d["radioVolumeType"])
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "radioVolumeType", %{data: d["radioVolumeType"]})
    {:noreply, socket}
  end

  def handle_event("radioVolumeTrack",d, socket) do
    IO.inspect(d)
    socket = assign(socket, :radioVolumeTrack, d["radioVolumeTrack"])
    res=MyXQL.query!(:myxql, "Update controls set radioVolumeTrack='#{d["radioVolumeTrack"]}' where id=1")
    # IO.inspect(d["radioVolumeTrack"])
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "radioVolumeTrack", %{data: d["radioVolumeTrack"]})
    {:noreply, socket}
  end

  def handle_event("wifi", d, socket) do
    # Handle the toggle event here
    IO.inspect(d)
    socket = assign(socket, :wifi, d["wifi"])
    res=MyXQL.query!(:myxql, "Update controls set wifi='#{d["wifi"]}' where id=1")
    HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "wifi", %{data: d["wifi"]})
    {:noreply, socket}
  end







  # def handle_event("on2", %{"peekWindowAngle1" => angle}, socket) do
  #   HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "e", %{data: "hi"})
  #   {:noreply, assign(socket, :peekWindowAngle, angle)}
  # end

  # def handle_event("submit_form", %{"select_box" => select_value, "radio_box" => radio_value}, socket) do
  #   socket = assign(socket, form_values: %{
  #     select_value: select_value,
  #     radio_value: radio_value
  #   })
  #   {:noreply, socket}
  # end




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
