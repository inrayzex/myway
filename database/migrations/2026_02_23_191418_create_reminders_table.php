<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

public function up(): void
{
    Schema::create('reminders', function (Blueprint $table) {
        $table->uuid('id')->primary();
        $table->foreignUuid('user_id')->constrained()->onDelete('cascade');
        $table->foreignUuid('practice_id')->constrained()->onDelete('cascade');
        $table->string('channel'); // email / push
        $table->timestamp('scheduled_at');
        $table->timestamp('sent_at')->nullable();
        $table->boolean('is_sent')->default(false);
        $table->timestamps();
    });
}

public function down(): void
{
    Schema::dropIfExists('reminders');
}


};
