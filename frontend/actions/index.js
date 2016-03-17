import reqwest from 'reqwest'
export const REQUEST_USER_INDEX = 'REQUEST_USER_INDEX'
export const RECEIVE_USER_INDEX = 'RECEIVE_USER_INDEX'
export const FAILED_USER_FETCH = 'FAILED_USER_FETCH'

export const requestUserIndex = () => {
  return {
    type: REQUEST_USER_INDEX
  };
};

export const receiveUserIndex = (user) => {
  return {
    type: RECEIVE_USER_INDEX,
    user
  };
};

export const failedUserFetch = (errors) => {
  return {
    type: FAILED_USER_FETCH
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
