

$ ->
  ## Simple AB Testing

  ABalytics.init terminology_experiment: [
    name: "static"
    experiment4_terminology: 'static'
  ,
    name: "html5"
    experiment4_terminology: 'HTML5'
  ]

  ABalytics.applyHtml()

  ga('set', 'dimension1', "terminology_experiment-1-" + ABalytics.changes[0][1] )

  $(".sign-up-button").on 'click', ->
    trackEvent("conversion", "sign-up", "Homepage Sign Up Button Clicked")

  ## UI

  goToByScroll = (id) ->
    $("html,body").animate
      scrollTop: $(id).offset().top
    , "slow"

  $(".down-hint a").click (e) ->
    e.preventDefault()
    goToByScroll $(this).attr("href")





