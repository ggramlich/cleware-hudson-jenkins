module.exports = (rest) ->
  # Calls the callback with an array [{"name":"..","url":"..","color":".."}, {...}, ...]
  listJobs: (url, callback) ->
    rest.get(url + '/api/json').on 'success', (res) ->
      callback res.jobs
  color: (url, job, callback) ->
    rest.get(url + '/job/' + job + '/api/json').on 'success', (res) ->
      callback res.color
