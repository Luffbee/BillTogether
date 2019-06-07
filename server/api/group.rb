class BilltogatherAPIv1 < Sinatra::Application
  namespace '/api/v1' do

    # Create a new group
    post '/groups' do
      uid = current_user['id']
      grp = Group.new(
        name: params['group-name'],
        desc: params['description'],
        joincode: params['join-code']
      )
      if grp.valid?
        grp.save
        grp.add_user(uid)
        MultiJson.dump({
          group: grp.to_api
        })
      else
        status 400
        MultiJson.dump({
          error: {
            message: grp.errors,
          }
        })
      end
    end

    # Get group list
    get '/groups' do
      uid = current_user['id']
      MultiJson.dump({
        grouplist: User[uid].groups.map { |g| g.to_api }
      })
    end

    # Join a group
    post '/groups/:id' do
      gid = params['id']
      if gid != params['group-id']
        halt 400, MultiJson.dump({
          error: {
            message: 'Form gid and URL gid is not identical.',
          }})
      end
      grp = Group[gid]
      uid = current_user['id']
      # already in the group
      if not (grp.nil? or grp.users_dataset[uid].nil?)
        return MultiJson.dump({
          group: grp.to_api,
        })
      end
      joincode = params['join-code']
      if grp.nil? or grp.joincode != joincode
        halt 403, MultiJson.dump({
          error: {
            message: 'Invalid group id or join code.'
          }})
      end
      uid = current_user['id']
      grp.add_user(uid)
      MultiJson.dump({
        group: grp.to_api,
      })
    end

  end
end
