class ulss_coverage extends uvm_subscriber#(ulss_tx);
    ulss_tx tx;

//factory registration
    `uvm_component_utils(ulss_coverage)

covergroup ulss_io_cg();

                cp_rst: coverpoint tx.rate_limiter_16to4_rstn 
                {bins active = {1}; 
                 bins low = {0}; 
               } 

                cp_soft_reset: coverpoint tx.rate_limiter_16to4_sw_rst 
                {bins active = {1}; 
                 bins low  = {0}; 
                }

//---------------------------------------------------------------------------                
                
                cp_wr_en:coverpoint tx.sch_reg_wr_en{
                    bins enable={1};bins not_enabled={0};
                }

                cp_wr_addr:coverpoint tx.sch_reg_wr_addr{

                    bins addr[]={5'd0,5'd1,5'd2,5'd3,5'd4,5'd5,5'd6,5'd7,5'd8,5'd9,5'd10,5'd11,5'd12,
                                    5'd13,5'd15,5'd16,5'd17,5'd18,5'd19};
                }

                cp_wr_data:coverpoint tx.sch_reg_wr_data{
                    option.auto_bin_max=64;
                }
//----------------------------------------------------------------------------
                 cp_pck_str_empty_0:coverpoint tx.pck_str_empty_0{
                    bins empty ={1}; bins not_empty={0};
                 }

                 cp_pck_str_empty_1:coverpoint tx.pck_str_empty_1{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_2:coverpoint tx.pck_str_empty_2{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_3:coverpoint tx.pck_str_empty_3{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_4:coverpoint tx.pck_str_empty_4{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_5:coverpoint tx.pck_str_empty_5{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_6:coverpoint tx.pck_str_empty_6{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_7:coverpoint tx.pck_str_empty_7{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_8:coverpoint tx.pck_str_empty_8{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_9:coverpoint tx.pck_str_empty_9{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_10:coverpoint tx.pck_str_empty_10{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_11:coverpoint tx.pck_str_empty_11{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_12:coverpoint tx.pck_str_empty_12{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_13:coverpoint tx.pck_str_empty_13{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_14:coverpoint tx.pck_str_empty_14{
                                   bins empty ={1}; bins not_empty={0};
                                }
                 cp_pck_str_empty_15:coverpoint tx.pck_str_empty_15{
                                   bins empty ={1}; bins not_empty={0};
                                }
                               

//----------------------------------------------------------------------------
                     cp_sop_0: coverpoint tx.in_sop_0{
                 bins seen = {1};bins idle ={0};

                    }

                     cp_sop_1: coverpoint tx.in_sop_1{
                 bins seen = {1};bins idle ={0};

                    }
                    cp_sop2: coverpoint tx.in_sop_2{
                 bins seen = {1};bins idle ={0};

                    }
                    cp_sop_3: coverpoint tx.in_sop_3{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_4: coverpoint tx.in_sop_4{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_5: coverpoint tx.in_sop_5{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_6: coverpoint tx.in_sop_6{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_7: coverpoint tx.in_sop_7{
                 bins seen = {1};bins idle ={0};

                    }
                    cp_sop_8: coverpoint tx.in_sop_8{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_9: coverpoint tx.in_sop_9{
                 bins seen = {1};bins idle ={0};

                    }
                    cp_sop_10: coverpoint tx.in_sop_10{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_11: coverpoint tx.in_sop_11{
                 bins seen = {1};bins idle ={0};

                    }
                    cp_sop_12: coverpoint tx.in_sop_12{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_13: coverpoint tx.in_sop_13{
                 bins seen = {1};bins idle ={0};

                    }
                    cp_sop_14: coverpoint tx.in_sop_14{
                 bins seen = {1};bins idle ={0};

                    } 
                    cp_sop_15: coverpoint tx.in_sop_15{
                 bins seen = {1};bins idle ={0};

              }

          //    ------------------------------------------------------------------------------------------
          cp_in_stream_0:coverpoint tx.in_stream_0{

               option.auto_bin_max = 64; 
          }

            cp_in_stream_1:coverpoint tx.in_stream_1{

               option.auto_bin_max = 64; 
          }  
          cp_in_stream_2:coverpoint tx.in_stream_2{

               option.auto_bin_max = 64; 
          }  
          cp_in_stream_3:coverpoint tx.in_stream_3{

               option.auto_bin_max = 64; 
          }  
          cp_in_stream_4:coverpoint tx.in_stream_4{

               option.auto_bin_max = 64; 
          } 
          cp_in_stream_5:coverpoint tx.in_stream_5{

               option.auto_bin_max = 64; 
          }
          cp_in_stream_6:coverpoint tx.in_stream_6{

               option.auto_bin_max = 64; 
          }  
          cp_in_stream_7:coverpoint tx.in_stream_7{

               option.auto_bin_max = 64; 
          } 
          cp_in_stream_8:coverpoint tx.in_stream_8{

               option.auto_bin_max = 64; 
          } 
          cp_in_stream_9:coverpoint tx.in_stream_9{

               option.auto_bin_max = 64; 
          } 
          cp_in_stream_10:coverpoint tx.in_stream_10{

               option.auto_bin_max = 64; 
          } 
          cp_in_stream_11:coverpoint tx.in_stream_11{

               option.auto_bin_max = 64; 
          } 
          cp_in_stream_12:coverpoint tx.in_stream_12{

               option.auto_bin_max = 64; 
          }
          cp_in_stream_13:coverpoint tx.in_stream_13{

               option.auto_bin_max = 64; 
          }
          cp_in_stream_14:coverpoint tx.in_stream_14{

               option.auto_bin_max = 64; 
          } 
          cp_in_stream_15:coverpoint tx.in_stream_15{

               option.auto_bin_max = 64; 
          } 
         
         //--------------------------------------------------------------------------------------------
         
         cp_in_eop_0:coverpoint tx.in_eop_0{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_1:coverpoint tx.in_eop_1{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_2:coverpoint tx.in_eop_2{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_3:coverpoint tx.in_eop_3{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_4:coverpoint tx.in_eop_4{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_5:coverpoint tx.in_eop_5{
                bins seen = {1};bins idle ={0};
         }

         cp_in_eop_6:coverpoint tx.in_eop_6{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_7:coverpoint tx.in_eop_7{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_8:coverpoint tx.in_eop_8{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_9:coverpoint tx.in_eop_9{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_10:coverpoint tx.in_eop_10{
                bins seen = {1};bins idle ={0};
         }

         cp_in_eop_11:coverpoint tx.in_eop_11{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_12:coverpoint tx.in_eop_12{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_13:coverpoint tx.in_eop_13{
                bins seen = {1};bins idle ={0};
         }

        cp_in_eop_14:coverpoint tx.in_eop_14{
                bins seen = {1};bins idle ={0};
         }


        cp_in_eop_15:coverpoint tx.in_eop_15{
                bins seen = {1};bins idle ={0};
         }


//-------------------------------------------------------------------------------------
         // Output Ports Coverage

        cp_out_sop_0:coverpoint tx.out_sop_0{
                  bins seen = {1};bins idle ={0};

        }

        cp_out_sop_1:coverpoint tx.out_sop_1{
                  bins seen = {1};bins idle ={0};

        }

         cp_out_sop_2:coverpoint tx.out_sop_2{
                  bins seen = {1};bins idle ={0};

        }

        cp_out_sop_3:coverpoint tx.out_sop_3{
                  bins seen = {1};bins idle ={0};

        }

//------------------------------------------------------------------------------

       cp_out_stream_0:coverpoint tx.out_stream_0{
                  option.auto_bin_max = 64; 

       }
  
       cp_out_stream_1:coverpoint tx.out_stream_1{
                  option.auto_bin_max = 64; 

       }
       cp_out_stream_2:coverpoint tx.out_stream_2{
                  option.auto_bin_max = 64; 

       }
       cp_out_stream_3:coverpoint tx.out_stream_3{
                  option.auto_bin_max = 64; 

       }
 
//-------------------------------------------------------------------------------

        cp_out_eop_0:coverpoint tx.out_eop_0{
                  bins seen = {1};bins idle ={0};

        }

        cp_out_eop_1:coverpoint tx.out_eop_1{
                  bins seen = {1};bins idle ={0};

        }

         cp_out_eop_2:coverpoint tx.out_eop_2{
                  bins seen = {1};bins idle ={0};

        }

        cp_out_eop_3:coverpoint tx.out_eop_3{
                  bins seen = {1};bins idle ={0};

        }

//--------------------------------------------------------------------------------
        cp_pck_rd_en_grnt_0:coverpoint tx.pck_rd_en_grnt_0{
                  bins recieved ={1};bins not_recieved ={0};
        }

        cp_pck_rd_en_grnt_1:coverpoint tx.pck_rd_en_grnt_1{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_2:coverpoint tx.pck_rd_en_grnt_2{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_3:coverpoint tx.pck_rd_en_grnt_3{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_4:coverpoint tx.pck_rd_en_grnt_4{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_5:coverpoint tx.pck_rd_en_grnt_5{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_6:coverpoint tx.pck_rd_en_grnt_6{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_7:coverpoint tx.pck_rd_en_grnt_7{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_8:coverpoint tx.pck_rd_en_grnt_8{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_9:coverpoint tx.pck_rd_en_grnt_9{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_10:coverpoint tx.pck_rd_en_grnt_10{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_11:coverpoint tx.pck_rd_en_grnt_11{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_12:coverpoint tx.pck_rd_en_grnt_12{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_13:coverpoint tx.pck_rd_en_grnt_13{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_14:coverpoint tx.pck_rd_en_grnt_14{
                         bins recieved ={1};bins not_recieved ={0};
               }
        cp_pck_rd_en_grnt_15:coverpoint tx.pck_rd_en_grnt_15{
                         bins recieved ={1};bins not_recieved ={0};
               }
       
endgroup
   
    function new(string name,uvm_component parent);
        super.new(name,parent);
        ulss_io_cg  = new();
    endfunction
    

    virtual function void write(ulss_tx t);
        this.tx = t;

        if (t != null) begin
            ulss_io_cg.sample();
        end
    endfunction

endclass

