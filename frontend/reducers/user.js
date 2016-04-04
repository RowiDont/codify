import * as types from '../constants/index'

let defaultState = {
    loggedIn: false,
    isFetching: false,
    projects: [],
    categories: []
}

export function userIndex(state = defaultState, action) {
  switch (action.type) {
  case types.REQUEST_USER_INDEX:
    return Object.assign({}, state, {
      isFetching: true
    });
  case types.RECEIVE_USER_INDEX:
    return Object.assign({}, state, {
      loggedIn: true,
      isFetching: false
    }, action.user);
  case types.FAILED_USER_FETCH:
    return Object.assign({}, state, {
      loggedIn: false,
      isFetching: false
    });
  default:
    return state;
  }
}
