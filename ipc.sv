class fork_join;
  semaphore s;
  function new();
    s = new(0); 
  endfunction
  
  task process();
    fork
      begin    
        $display("@%0d\tProcess-1 Started",$time);
        #5;
        $display("@%0d\tProcess-1 Finished",$time);
        s.put(1);
      end
      
      begin
        $display("@%0d\tProcess-2 Started",$time);
        #10;
        $display("@%0d\tProcess-2 Finished",$time);
        s.put(1);
      end 
      begin
        $display("@%0d\tProcess-3 Started",$time);
        #55;
        $display("@%0d\tProcess-3 Finished",$time);
        s.put(1);
      end
    
    join_any
    //join_none
    
    s.get(2);         //2 for 2 process to complete 
    
    disable fork;
      $display("@%0d\tProcess Killed",$time);
   endtask
endclass


module m1;
  fork_join f1;
  initial begin
    f1=new();
    f1.process();
  end
endmodule      
