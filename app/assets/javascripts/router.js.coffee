# For more information see: http://emberjs.com/guides/routing/
ETahi.Router.map ()->
  @resource('paper', { path: '/papers/:paper_id' }, ->
    @route('manage'))

ETahi.Router.reopen({
  rootURL: '/ember/'
})
