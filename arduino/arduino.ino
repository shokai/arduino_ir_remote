#define IR_DATA_SIZE 768
byte ir_data[IR_DATA_SIZE];
unsigned int ir_index;
#define PIN_LED 13
#define PIN_IR_IN 3
#define PIN_IR_OUT 12

void setup(){
  Serial.begin(57600);
  pinMode(PIN_IR_IN, INPUT);
  pinMode(PIN_IR_OUT, OUTPUT);
  pinMode(PIN_LED, OUTPUT);
}

unsigned int analog_count = 0;
void loop(){
  if(Serial.available()){
    char recv = Serial.read();
    process_input(recv);
  }
  else{
    if(analog_count < 1){
      for(byte i = 0; i < 6; i++){
        Serial.print("ANALOG");
        Serial.println(i);
        Serial.println(analogRead(i));
      }
    }
    analog_count += 1;
    if(analog_count > 65534) analog_count = 0;
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
    if(ir_data[i] < 1) break;
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
        delayMicroseconds(8);
      }
    }
    else{
      while(micros() - start_at < interval_sum);
    }
  }
}

void process_input(char input){
  if(input == 'r'){
    digitalWrite(PIN_LED, true);
    ir_read(PIN_IR_IN);
    Serial.println("READ");
    ir_print();
    digitalWrite(PIN_LED, false);
  }
  else if(input == 'w'){
    for(ir_index = 0; ir_index < IR_DATA_SIZE; ir_index++){
      ir_data[ir_index] = 0;
    }
    ir_index = 0;
  }
  else if(input == ','){
    if(ir_index < IR_DATA_SIZE) ir_index += 1;
  }
  else if(input >= '0' && '9' >= input){
    ir_data[ir_index] = ir_data[ir_index]*10 + (input - '0');
  }
  else if(input == 'W'){
    digitalWrite(PIN_LED, true);
    ir_write(PIN_IR_OUT);
    ir_index = 0;
    Serial.println("WRITE");
    ir_print();
    digitalWrite(PIN_LED, false);
  }
}
