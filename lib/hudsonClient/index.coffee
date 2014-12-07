module.exports = (rest, _) ->
  appendIfMissing = (string, suffix) ->
    return string if string.slice(-suffix.length) is suffix
    "#{string}#{suffix}"

  (server) ->
    server = appendIfMissing server, '/'

    # Calls the callback with an array [{"name":"..","url":"..","color":".."}, {...}, ...]
    listJobsInView: (view, callback) ->
      rest.get("#{server}view/#{view}/api/json").on 'success', (res) ->
        callback res.jobs

    # Calls the callback with an array [{"name":"..","url":"..","color":".."}, {...}, ...]
    listJobs: (callback) ->
      rest.get("#{server}api/json").on 'success', (res) ->
        callback res.jobs

    colorOfJob: (job, callback) ->
      rest.get("#{server}job/#{job}/api/json?tree=name,color").on 'success', (res) ->
        callback res.color

    colorsInView: (view, callback) ->
      rest.get("#{server}view/#{view}/api/json?tree=jobs[name,color]").on 'success', (res) ->
        colorsInView = _.mapValues(_.indexBy(res.jobs, 'name'), 'color')
        callback colorsInView
