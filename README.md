# Group Project - *SimpleP Project Management*

## Overview

**SimpleP** is an intuitive Project Management written in Ruby on Rails designed to drastically improve project without the needs of sophisticated softwares.

Each member signing up can create a team. A team can create projects, and projects contain tasks. In each tasks, users will assign owner, add followers, notes, comments, attachments and tags. In addition, when the state of a project or tasks changes, followers and owners get updates about the changes in their Dashboard.

## Group Infomation

- Group Name: 1000 Dollars Project Team.
- Contributes:
    + @hunterxx222
    + @se7oluti0n
    + @PrimeTimeTran
    + @narutoo9x

## Demo-Centric User Stories

#### General Functions

* [ ] User can search for tasks or projects they participate in.

#### Dashboard

* [ ] User can see a list of project tasks that passed the due date.
* [ ] User can see a list of tasks.

#### Team

* [ ] An user belongs to a Team.
* [ ] An user can belongs to many teams.

#### Users

* [ ] User can sign up for the service with Name, Email & Password.
* [ ] User can login using an email and password.
* [ ] User can create a project.

#### Projects

* [ ] After logging in, the user is taken to a page that has a list of projects sorted in descending chronological order (newest projects at top), a “New Projects” link.
* [ ] User can add tasks to the project it participate in.
* [ ] User can have different views to view his tasks: Show All Tasks, Show Completed Tasks, Completed Tasks This Week...etc

#### Tasks

* [ ] Only project members can view the project tasks.
* [ ] A task has only one “Owner” and can have many “Followers”.
* [ ] Users can mark the task completed.
* [ ] Users can create, update or delete subtasks.
* [ ] Users can leave/edit/delete comments on the task.
* [ ] Users can set a due date for the task.
* [ ] Tasks out-of-date will be showed as red.
* [ ] Users can edit the tasks.
* [ ] User can “Like” other’s tasks.

#### Conversation

* [ ] A coversation belongs to a team.
* [ ] User can send message to the team.
* [ ] User can send private message to other members.

#### Reporting

* [ ] User can see a calendar of tasks due date.

## Projects Wireframe
![Wireframe](docs/wireframe/wireframe.png)

## Models ER Diagram
![ER Diagrams](docs/models/simplep.png)
## License

    Copyright [2016] [1000 Dollars Project Team]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
