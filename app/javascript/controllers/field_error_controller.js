import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['message']

  connect() {
    const formControl = this.element.children[0]

    formControl.addEventListener('input', (e) => {
      e.target.classList.remove('field-with-error')
      this.messageTarget.textContent = ''
    })
    formControl.classList.add('field-with-error')
  }
}
