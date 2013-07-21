#define IR_DATA_SIZE 768
byte ir_data[IR_DATA_SIZE];
#define PIN_BTN 2
#define PIN_IR_IN 3
#define PIN_LED 13
#define PIN_IR_OUT 12
boolean btn_stat, btn_stat_p;

void setup(){
  Serial.begin(9600);
  delay(3000);
  pinMode(PIN_IR_IN, INPUT);
  pinMode(PIN_IR_OUT, OUTPUT);
  pinMode(PIN_BTN, INPUT);
  pinMode(PIN_LED, OUTPUT);
  btn_stat_p = btn_stat = digitalRead(PIN_BTN);
}

void loop(){
  if(Serial.available()){
    char recv = Serial.read();
    switch(recv){
    case 'r':
    case 'R':
      Serial.println("IR_READ_START");
      ir_read(PIN_IR_IN);
      Serial.println("IR_READ_END");
      ir_print();
      break;
    case 'w':
    case 'W':
      ir_write(PIN_IR_OUT);
      Serial.println("IR_WRITE");
      break;
    }
  }
}

void ir_read(byte ir_pin){
  unsigned int i, j;
  for(i = 0; i < IR_DATA_SIZE; i++){
    ir_data[i] = 0;
  }
  unsigned long now, last, start_at;
  boolean stat;
  start_at = micros();
  while(stat = digitalRead(ir_pin)){
    if(micros() - start_at > 2500000) return;    
  }
  start_at = last = micros();
  for(i = 0; i < IR_DATA_SIZE; i++){
    for(j = 0; ; j++){
      if(stat != digitalRead(ir_pin)) break;
      if(j > 65534) return;
    }
    now = micros();
    ir_data[i] = (now - last)/100;
    last = now;
    stat = !stat;
  }
}

void ir_print(){
  unsigned int i;
  for(i = 0; i < IR_DATA_SIZE; i++){
    Serial.print(ir_data[i]);
    Serial.print(",");
  }
  Serial.println();
}

void ir_write(byte ir_pin){
  unsigned int i;
  unsigned long interval_sum, start_at;
  interval_sum = 0;
  start_at = micros();
  for(i = 0; i < IR_DATA_SIZE; i++){
    if(ir_data[i] < 1) break;
    interval_sum += ir_data[i] * 100;
    if(i % 2 == 0){
      while(micros() - start_at < interval_sum){
        digitalWrite(ir_pin, true);
        delayMicroseconds(6);
        digitalWrite(ir_pin, false);
        delayMicroseconds(7);
      }
    }
    else{
      while(micros() - start_at < interval_sum);
    }
  }
}
