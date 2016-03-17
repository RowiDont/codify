import React, { Component, PropTypes } from 'react'
import { fetchUser } from '../actions/index'


class UserPage extends Component {
  componentWillMount() {
    this.props.dispatch(fetchUser())
  }

  render() {
    const { projects, categories, loggedIn } = this.props

    let link = <a href="#">login</a>
    if (loggedIn) {
      link = <a href="#">logout</a>
    }

    return(
      <div>
        { link }
        <h3>Projects:</h3>
        <ul>
          {projects.map(( project, index ) =>
            <li key={index}>{ project.title }</li>
          )}
        </ul>
        <h3>Categories:</h3>
        <ul>
          {categories.map((category, index) =>
            <li key={index}>{ category.name }</li>
          )}
        </ul>
      </div>
    )
  }
}

export default UserPage
