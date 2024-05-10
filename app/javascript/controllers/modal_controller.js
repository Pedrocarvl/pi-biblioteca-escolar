import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    connect() {
        this.modal = new bootstrap.Modal(this.element, {
            keyboard: false
        })
        this.modal.show()
        this.element.addEventListener('turbo:submit-end', (event) => {
            if (event.detail.success) {
                this.modal.hide()
                this.element.remove();
            }
        });
        this.element.addEventListener('hidden.bs.modal', (event) => {
            this.element.remove();
        })
    }
}