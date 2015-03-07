Document.ready? do

  trigger_btn = Element[".trigger-overlay"]
  popup       = Element[".overlay .popup"]
  wrapper     = Element[".wrapper"]
  overlay     = Element[".overlay"]
  close_btn   = Element["button.overlay-close"]
  body        = Element["body"]

  # trigger_btn.on :click do |event|
  #   item_id = event.current_target.data('id')
  #   overlay.add_class('open')
  #   wrapper.add_class('overlay-open')

  #   HTTP.get("/milestones/" + item_id.to_s + ".json") do |response|
  #     puts response.json[:milestone]
  #     Element['.overlay .title'].html(response.json[:milestone][:title])
  #     Element['.overlay .company'].html('at ' + response.json[:milestone][:company])
  #     Element['.overlay .location'].html(response.json[:milestone][:location])
  #     Element['.overlay .time'].html(response.json[:milestone][:time_period])
  #     Element['.overlay .description'].html(response.json[:milestone][:description])

  #   end

  #   false # event.prevent_default

  # end

  close_btn.on :click do |event|
    overlay.remove_class('open').add_class('close')
    wrapper.remove_class('overlay-open')
    body.remove_class('noscroll')
    false
  end

end