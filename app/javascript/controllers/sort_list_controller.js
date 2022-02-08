import { Controller } from '@hotwired/stimulus'
import Sortable from 'sortablejs'

const uiOptions = {
  handle: '.js-sortable-handle',
  scroll: true,
  animation: 150,
  easing: 'cubic-bezier(1, 0, 0, 1)',
  ghostClass: 'opacity-70',
}

export default class extends Controller {
  connect() {
    const url = this.data.get('url')
    const group = this.data.get('group')

    Sortable.create(this.element, {
      ...uiOptions,
      group: { name: group, pull: true, put: true },
      onEnd: function(e) {
        const payload = {
          from: e.from.dataset.sortListGroup,
          to: e.to.dataset.sortListGroup,
          item_id: e.item.dataset.id,
          to_index: e.newIndex,
        }
        //$.ajax({ type: 'PATCH', url: url, dataType: 'json', data: payload })
      }
    })
  }
}
