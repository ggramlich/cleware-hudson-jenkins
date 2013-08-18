module.exports = (rest) ->
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

    color: (job, callback) ->
      rest.get("#{server}job/#{job}/api/json").on 'success', (res) ->
        callback res.color
