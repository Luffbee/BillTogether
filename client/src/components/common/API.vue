<script>
import { store } from './Store.vue'

function v1Req(method, uri, callback, body=null) {
  var xhr = new XMLHttpRequest()
  xhr.onload = function() {
    if (this.status == 200) {
      callback(this.response)
    } else {
      store.apiError(this.response.error)
    }
  }
  xhr.open(method, '/api/v1' + uri)
  xhr.responseType = 'json'
  xhr.send(JSON.stringify(body))
}

let request = v1Req

export default {
  get: (uri, callback, body=null) => {
    request('GET', uri, callback, body)
  },
  post: (uri, callback, body=null) => {
    request('POST', uri, callback, body)
  },
  form2obj: (formId) => {
    var form = new FormData(document.getElementById(formId))
    var data = {}
    form.forEach((v, k) => { data[k] = v })
    return data
  },
}
</script>
