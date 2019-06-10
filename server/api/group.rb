class BilltogatherAPIv1 < Sinatra::Application
  namespace '/api/v1' do

    # Create a new group
    post '/groups' do
      uid = current_user['id']
      grp = Group.new(
        name: data['group-name'],
        desc: data['description'],
        joincode: data['join-code']
      )
      check(grp.valid?, 400, grp.errors)
      grp.save
      grp.add_user(uid)
      MultiJson.dump({
        group: grp.to_api
      })
    end

    # Get group list
    get '/groups' do
      uid = current_user['id']
      MultiJson.dump({
        grouplist: User[uid].groups.map { |g| g.to_intro }
      })
    end

    # Join a group
    post '/groups/:id' do
      gid = params['id']
      check(gid == data['group-id'],
            400, 'Form gid and URL gid is not identical.')
      grp = Group[gid]
      check(!grp.nil?, 400, 'No such group: GID=' + gid.to_s)
      uid = current_user['id']
      # already in the group
      if !grp.users_dataset[uid].nil?
        return MultiJson.dump({
          group: grp.to_api,
        })
      end
      joincode = data['join-code']
      check(grp.joincode == joincode,
        403, 'Invalid group id or join code.')
      uid = current_user['id']
      grp.add_user(uid)
      MultiJson.dump({
        group: grp.to_api,
      })
    end

    get '/groups/:id' do
      gid = params['id']
      uid = current_user['id']
      grp = Group[gid]
      check(!grp.nil?, 400, 'Invalid group id.')
      check(!grp.users_dataset[uid].nil?,
            403, 'You are not in this group: GID=' + gid.to_s)
      MultiJson.dump({
        group: grp.to_api,
      })
    end

  end
end
