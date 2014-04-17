def create_user_group
	create_group
	@users_group = FactoryGirl.create(:users_group, user_id: @user.id, group_id: @group.id)
end

def create_group
	@group = FactoryGirl.create(:group)
end