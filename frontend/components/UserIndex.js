import { connect } from 'react-redux'
import UserPage from '../containers/userPage'

const mapStateToProps = (state) => {
  return {
    projects: state.userIndex.projects,
    categories: state.userIndex.categories,
    loggedIn: state.userIndex.loggedIn
  }
}

const UserIndex = connect(
  mapStateToProps
)(UserPage)

export default UserIndex
