class MedicinesController < ApplicationController

  def index
    # finding all the active medicines and paginating that list (will_paginate)
    @medicines = Medicine.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @medicine = Medicine.find(params[:id])
    # get all the pets for this medicine
    @for_animals = @medicine.animals.alphabetical.all
  end

  def new
    @medicine = Medicine.new
  end

  def edit
    @medicine = Medicine.find(params[:id])
  end

  def create
    @medicine = Medicine.new(params[:medicine])
    if @medicine.save
      # if saved to database
      flash[:notice] = "Successfully created #{@medicine.name}."
      redirect_to @medicine # go to show medicine page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @medicine = Medicine.find(params[:id])
    if @medicine.update_attributes(params[:medicine])
      flash[:notice] = "Successfully updated #{@medicine.name}."
      redirect_to @medicine
    else
      render :action => 'edit'
    end
  end

  def destroy
    @medicine = Medicine.find(params[:id])
    @medicine.destroy
    flash[:notice] = "Successfully removed #{@medicine.name} from the PATS system."
    redirect_to medicines_url
  end
end
