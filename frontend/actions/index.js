import reqwest from 'reqwest'
import * as types from '../constants/index'

export const requestUserIndex = () => {
  return {
    type: types.REQUEST_USER_INDEX
  };
};

export const receiveUserIndex = (user) => {
  return {
    type: types.RECEIVE_USER_INDEX,
    user
  };
};

export const failedUserFetch = (errors) => {
  return {
    type: types.FAILED_USER_FETCH
  };
};

export function fetchUser() {
  return dispatch => {
    dispatch(requestUserIndex());
    return(
      reqwest({
        url: "api/user",
        method: "GET",
        type: "json"
      })
      .then(data => dispatch(receiveUserIndex(data)))
      .fail(data => dispatch(failedUserFetch(data)))
    )
  };
}
