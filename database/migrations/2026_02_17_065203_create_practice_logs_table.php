<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void

{

    Schema::create('practice_logs', function (Blueprint $table) {

        $table->uuid('id')->primary();

        $table->foreignUuid('practice_id')->constrained()->onDelete('cascade');

        $table->foreignUuid('user_id')->constrained()->onDelete('cascade');

        $table->timestamp('completed_at')->useCurrent();

        $table->integer('value')->nullable();

        $table->text('note')->nullable();

        $table->string('photo_url')->nullable();

        $table->timestamps();

    });

}



public function down(): void

{

    Schema::dropIfExists('practice_logs');

}
};
