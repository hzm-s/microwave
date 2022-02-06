import { Application } from "@hotwired/stimulus"

import Dropdown from "stimulus-dropdown"
import Reveal from "stimulus-reveal-controller"

const application = Application.start()
application.register('dropdown', Dropdown)
application.register('reveal', Reveal)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
