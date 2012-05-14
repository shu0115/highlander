# coding: utf-8
class <%= controller_class_name %>Controller < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @<%= plural_table_name %> = <%= "#{class_name}.where( user_id: session[:user_id] ).all" %>
  end

  #------#
  # show #
  #------#
  def show
    @<%= singular_table_name %> = <%= "#{class_name}.where( id: params[:id], user_id: session[:user_id] ).first" %>
  end

  #-----#
  # new #
  #-----#
  def new
    @<%= singular_table_name %> = <%= orm_class.build( class_name ) %>
    
    @submit = "create"
  end

  #------#
  # edit #
  #------#
  def edit
    @<%= singular_table_name %> = <%= "#{class_name}.where( id: params[:id], user_id: session[:user_id] ).first" %>
    
    @submit = "update"
  end

  #--------#
  # create #
  #--------#
  def create
    @<%= singular_table_name %> = <%= orm_class.build( class_name, " params[:#{singular_table_name}] " ) %>
    @<%= "#{singular_table_name}.user_id" %> = <%= "session[:user_id]" %>

    if @<%= orm_instance.save %>
      redirect_to( { action: "index" }, notice: <%= "\"#{human_name} was successfully created.\"" %> )
    else
      render action: "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @<%= singular_table_name %> = <%= "#{class_name}.where( id: params[:id], user_id: session[:user_id] ).first" %>

    if @<%= orm_instance.update_attributes(" params[:#{singular_table_name}] ") %>
      redirect_to( { action: "show", id: <%= "params[:id]" %> }, notice: <%= "\"#{human_name} was successfully updated.\"" %> )
    else
      render action: "edit", id: <%= "params[:id]" %>
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @<%= singular_table_name %> = <%= "#{class_name}.where( id: params[:id], user_id: session[:user_id] ).first" %>
    @<%= orm_instance.destroy %>

    redirect_to action: "index"
  end

end
