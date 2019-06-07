<template>
  <div id="home">
    <div id="user-area">
      Current user:
      <UserInfo
        v-bind="user"
      ></UserInfo>
      <button @click="logout">Logout</button>
    </div>
    <div id="group-area">
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
    <div id="extra-area" v-if="showExtra">
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
import GroupInfo from './group/GroupInfo.vue'
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
    updateExtraView(view, props=null) {
      this.showExtra = true
      this.extraView = view
      this.extraVV = 1 - this.extraVV
      this.props = props
    },
    goJoinGroup() {
      this.updateExtraView(JoinGroup)
    },
    goCreateGroup() {
      this.updateExtraView(CreateGroup)
    },
    goGroupDetail(idx) {
      this.updateExtraView(GroupInfo,
        {
          detail: true,
          ...this.groups[idx],
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
</style>
