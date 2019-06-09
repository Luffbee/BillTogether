<template>
  <div id="home">
    <div id="user" class="area">
      Current user:<br>
      <UserInfo
        v-bind="user"
      ></UserInfo><br>
      <button @click="logout">Logout</button>
    </div>
    <div id="group" class="area">
      <div id="new-groups">
        <button @click="goJoinGroup">Join</button> or
        <button @click="goCreateGroup">Create</button><br>
        a new group.
      </div>
      <GroupList
        :groups="groups"
        @groupDetail="goGroupDetail($event)"
      ></GroupList>
    </div>
    <div id="extra" class="area" v-if="showExtra">
      <component
        :is="extraView"
        :key="extraVV"
        v-bind="props"
        @update="updateGroups"
        @close="showExtra=false"
      ></component>
    </div>
  </div>
</template>

<script>
import { store } from './common/Store.vue'
import API from './common/API.vue'
import UserInfo from './user/UserInfo.vue'
import GroupList from './group/GroupList.vue'
import GroupDetail from './group/GroupDetail.vue'
import JoinGroup from './group/JoinGroup.vue'
import CreateGroup from './group/CreateGroup.vue'

export default {
  data() {
    return {
      user: store.state.user,
      showExtra: false,
      extraView: null,
      // use this to force re render extraView
      extraVV: 0,
      props: {},
      groups: [
        {
          id: 1,
          name: "g1",
          desc: "testing",
          create_time: "12345",
          joincode: "qwert",
          users: [
            {
              id: 1,
              name: "lyfaaa",
              email: "lyf@aaa.com",
            },
          ],
        },
        {
          id: 2,
          name: "g2",
          desc: "testing2",
          create_time: "12445",
          joincode: "qwertt",
          users: [
            {
              id: 1,
              name: "lyfaaa",
              email: "lyf@aaa.com",
            },
            {
              id: 2,
              name: "lyfbbb",
              email: "lyf@bbb.com",
            },
          ],
        },
      ],
    }
  },
  created() {
    this.updateGroups()
  },
  components: {
    UserInfo,
    GroupList,
  },
  methods: {
    logout() {
      API.post('/logout', () => {
        store.logoutSuccess()
      })
    },
    updateGroups() {
      API.get('/groups', (resp) => {
        this.groups = resp.grouplist
        for (let i = 0; i < this.groups.length; i++) {
          this.groups[i].idx = i
        }
      })
    },
    updateExtraView(view, updateVV=true, props=null) {
      this.showExtra = true
      this.extraView = view
      this.props = props
      if (updateVV) {
        this.extraVV = 1 - this.extraVV
      }
    },
    goJoinGroup() {
      this.updateExtraView(JoinGroup)
    },
    goCreateGroup() {
      this.updateExtraView(CreateGroup)
    },
    goGroupDetail(idx) {
      var gid = this.groups[idx].id.toString()
      API.get('/groups/' + gid, (resp) => {
        this.updateExtraView(GroupDetail, false, resp.group)
      })
    }
  }
}
</script>

<style>
#home {
  display: flex;
  justify-content: center;
}
.area {
  border: solid 1px;
  padding: 2em;
  margin: 1em;
}
</style>
