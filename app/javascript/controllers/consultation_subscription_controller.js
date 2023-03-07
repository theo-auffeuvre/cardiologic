import { Controller } from "@hotwired/stimulus"
import {  createConsumer } from "@rails/actioncable"

// Connects to data-controller="consultation-subscription"
export default class extends Controller {

  static values = { consultationId: Number }
  static targets = ["messages"]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ConsultationChannel", id: 9},
      { received: data => this.#insertMessageAndScrollDown(data) },
    );
    console.log(this.messagesTarget);
    console.log(`Subscribed to the consultation with the id ${9}`)
  }

  #insertMessageAndScrollDown(data) {
    console.log(`Received data: ${data}`);
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  resetForm(event){
    event.target.reset()
  }
}
