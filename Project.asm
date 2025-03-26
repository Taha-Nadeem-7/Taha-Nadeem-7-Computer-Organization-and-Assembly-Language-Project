.model small
.stack 100h
.data
    titlemsg db "____________________ Welcome! to Rock-Paper-Scissors Game. _____________________$"    
    msg1 db "Player 1: Enter your choice [1 For Rock] [2 For Paper] [3 For scissors]: $" 
    msg2 db "Player 2: Enter your choice [1 For Rock] [2 For Paper] [3 For scissors]: $" 
    
    tie_msg db '____________________ Its a tie! _____________________$'
    player1_wins_rounds db '____________________ Player 1 wins this round _____________________$'
    player2_wins_rounds db '____________________ Player 2 wins this round _____________________$'   
    
    player1_wins_whole db '________________________________ Player 1 wins! ________________________________$'
    player2_wins_whole db '________________________________ Player 2 wins! ________________________________$' 
    
    player1_choice db ? 
    player2_choice db ?     
    
    player1_score db 0 
    player2_score db 0 
    rounds db 3 
.code 
main proc
    mov ax,@data
    mov ds,ax 
    
     
    lea dx, titlemsg
    mov ah,09h 
    int 21h    
    mov dx, 0Ah
    mov ah, 02h 
    int 21h 
        
    mov dx, 0Ah
    mov ah, 02h 
    int 21h   
                    
    mov dx,0DH
    mov ah, 02h 
    int 21h                    

    MOV Cl,rounds
    
    inputs:  
    lea dx, msg1
    mov ah,09h 
    int 21h
            
    mov ah, 0                   
    int 16h  
    sub al, '0'      
    mov player1_choice,al 
    mov bl,player1_choice
    
    mov dx, 0Ah
    mov ah, 02h 
    int 21h   
                    
    mov dx,0DH
    mov ah, 02h 
    int 21h  
    
    cmp bl,1
    jl inputs
    
    cmp bl,3
    jg inputs
               
    mov dx, 0Ah
    mov ah, 02h 
    int 21h   
                    
    mov dx,0DH
    mov ah, 02h 
    int 21h
    
    jmp input_player2      
    
    input_player2:
     
    lea dx, msg2
    mov ah,09h 
    int 21h            

    mov ah, 0                   
    int 16h 
    sub al, '0' 
                    
    mov player2_choice,al 
    
    mov bh,player2_choice 
    
            
    mov dx, 0Ah
    mov ah, 02h 
    int 21h   
                    
    mov dx,0DH
    mov ah, 02h 
    int 21h
    
    cmp bh,1
    jl input_player2
    
    cmp bh,3
    jg input_player2 
                                
        
    mov dx, 0Ah
    mov ah, 02h 
    int 21h   
                    
    mov dx,0DH
    mov ah, 02h 
    int 21h
 
    
    cmp bl,bh
    je tiegame   
    
    cmp bl,1 
    je player1_choice_rock
    
    cmp bl,2 
    je player1_choice_paper  
    
    cmp bl,3 
    je player1_choice_scissors
    
    
    
    player1_choice_rock:
        cmp bh,3
        je player1won 
            
        cmp bh,2
        je player2won
    player1_choice_paper:
        cmp bh,1
        je player1won
            
        cmp bh,3
        je player2won
            
     player1_choice_scissors:
        cmp bh,1
        je player1won
            
        cmp bh,2
        je player2won
        
            
        
    player1won:
    lea dx, player1_wins_rounds
    mov ah,09h 
    int 21h 
    
    INC player1_score  
    jmp roundover 
    
    player2won:
    lea dx, player2_wins_rounds
    mov ah,09h 
    int 21h   
    
    INC player2_score
    jmp roundover 
    
    tiegame:   
    lea dx, tie_msg
    mov ah,09h 
    int 21h

    jmp roundover
    
      
    roundover:
    DEC Cl   
    mov dx, 0Ah
    mov ah, 02h 
    int 21h   
                    
    mov dx,0DH
    mov ah, 02h 
    int 21h
    
       
    mov dx, 0Ah
    mov ah, 02h 
    int 21h
    
    jnz inputs
    
    
    mov bl,player1_score
    mov bh,player2_score
    
    cmp bl,bh
    je tie 
    jg player1winner
    jl player2winner
    
    tie:
        lea dx, tie_msg
        mov ah,09h 
        int 21h
        jmp gameover       
        
    player1winner:
        lea dx, player1_wins_whole
        mov ah,09h 
        int 21h
        jmp gameover 
    
    player2winner:
        lea dx, player2_wins_whole
        mov ah,09h 
        int 21h
        jmp gameover 
         
gameover:    
    mov ah, 4Ch               
    int 21h
    main endp
    
    end main