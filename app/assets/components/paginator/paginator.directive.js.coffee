angular.module 'jquest'
  .service 'Paginator', ->
    class Paginator
      constructor: (objects)->
        # Alway start at 1
        @page = 1
        # Paginate according the orignal set size
        @limit = Math.max(1, objects.length)
        # Every object
        @objects = objects
        # If no object is given, the set must be empty
        @over = @busy = objects.length is 0
      # Load more object!
      next: =>
        # We are busy to load some object here...
        @busy = yes
        # Increment page
        @page = @page + 1
        # Copy existing parameters
        params = @objects.reqParams or {}
        # And extend them with the current bounds
        params = angular.extend params, limit: @limit, page: @page
        # Use the existing object instance
        @objects.getList(params).then (objects)=>
          # Just add the new object
          @objects.push object for object in objects
          # We're not buzy anymore.
          # Is there any object left?
          @busy = @over = objects.length < @limit
