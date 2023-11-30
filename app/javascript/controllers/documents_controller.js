import { Controller } from "@hotwired/stimulus"
export const count = {
  i: 0
}

// Connects to data-controller="documents"
export default class extends Controller {
  static targets = ["fileField"]

  connect() {
  }

  addDocument(e) {
    e.preventDefault()
    let i = count["i"] ++
    const file_field =  this.fileFieldTarget
    if(i < 2){
      const clonedField = file_field.cloneNode(true)
      clonedField.setAttribute('id', `user_documents_${i}`)
      file_field.after(clonedField)
    }
  }

  remove(e){
    e.preventDefault()
    var filefields = document.getElementById('filefield');
    var input_tags =  filefields.getElementsByTagName('input');
    if(input_tags.length > 2) {
      filefields.removeChild(input_tags[input_tags.length - 1]);
    }
  }

}
