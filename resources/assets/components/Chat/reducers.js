import { unionWith } from 'lodash';

export function messagesReducer (state, action) {
  const reset = [];
  
  switch (action.type) {
    case 'add':
      return unionWith(state, action.payload, function (a, b) {
        return a.id === b.id
      }).sort(function (a, b) {
        const aData = a.data()
        const bData = b.data()

        return bData.created_at.seconds - aData.created_at.seconds
      })
      case 'reset':
          return reset;
      
    default:
      throw new Error('Action type is not implemented!')
  }
}