import { Controller } from '@hotwired/stimulus'

export default class extends Controller
  connect: ->
    console.log 'whoo'
    @element.textContent = 'Hello World!'
