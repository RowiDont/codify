import {
  REQUEST_USER_INDEX,
  RECEIVE_USER_INDEX,
  FAILED_USER_FETCH
} from '../actions/index';

let defaultState = {
    loggedIn: false,
    isFetching: false,
    projects: [],
    categories: []
}

export function userIndex(state = defaultState, action) {
  switch (action.type) {
  case REQUEST_USER_INDEX:
    return Object.assign({}, state, {
      isFetching: true
    });
  case RECEIVE_USER_INDEX:
    return Object.assign({}, state, {
      loggedIn: true,
      isFetching: false
    }, action.user);
  case FAILED_USER_FETCH:
    return Object.assign({}, state, {
      loggedIn: false,
      isFetching: false
    });
  default:
    return state;
  }
}
